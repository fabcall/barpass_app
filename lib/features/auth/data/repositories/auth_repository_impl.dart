import 'package:barpass_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:barpass_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:barpass_app/features/auth/domain/entities/auth_session.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<String, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Faz login no backend
      final sessionModel = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      // Salva sessão localmente
      await _localDataSource.saveSession(sessionModel);

      // Converte para entity e retorna
      return right(sessionModel.toEntity());
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, AuthSession>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Registra no backend
      final sessionModel = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );

      // Salva sessão localmente
      await _localDataSource.saveSession(sessionModel);

      // Converte para entity e retorna
      return right(sessionModel.toEntity());
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, AuthSession>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      // Renova token no backend
      final sessionModel = await _remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );

      // Salva nova sessão localmente
      await _localDataSource.saveSession(sessionModel);

      // Converte para entity e retorna
      return right(sessionModel.toEntity());
    } catch (e) {
      // Se falhar ao renovar, limpa a sessão local
      await _localDataSource.clearSession();
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, bool>> validateSession() async {
    try {
      // Obtém sessão local
      final sessionModel = await _localDataSource.getSession();

      if (sessionModel == null) {
        return right(false);
      }

      final session = sessionModel.toEntity();

      // Se expirou, retorna false
      if (session.isExpired) {
        return right(false);
      }

      // Valida com o backend (opcional)
      final isValid = await _remoteDataSource.validateAccessToken(
        accessToken: session.accessToken,
      );

      return right(isValid);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, AuthSession?>> getCurrentSession() async {
    try {
      final sessionModel = await _localDataSource.getSession();

      if (sessionModel == null) {
        return right(null);
      }

      return right(sessionModel.toEntity());
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      // Obtém a sessão atual para pegar o userId
      final sessionModel = await _localDataSource.getSession();

      if (sessionModel != null) {
        // Invalida no backend
        await _remoteDataSource.logout(userId: sessionModel.userId);
      }

      // Limpa sessão local
      await _localDataSource.clearSession();

      return right(null);
    } catch (e) {
      // Mesmo com erro, limpa a sessão local
      await _localDataSource.clearSession();
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<bool> hasActiveSession() async {
    return _localDataSource.hasValidSession();
  }

  @override
  Future<Either<String, void>> sendPasswordResetCode({
    required String email,
  }) async {
    try {
      await _remoteDataSource.sendPasswordResetCode(email: email);
      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final token = await _remoteDataSource.verifyOtp(
        email: email,
        code: code,
      );
      return right(token);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, void>> changePassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        token: token,
        newPassword: newPassword,
      );

      // Limpa a sessão local por segurança
      await _localDataSource.clearSession();

      return right(null);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Método auxiliar para garantir que a sessão é válida
  /// Renova automaticamente se necessário
  Future<Either<String, AuthSession>> ensureValidSession() async {
    final sessionResult = await getCurrentSession();

    return sessionResult.fold(
      (error) => left(error),
      (session) async {
        if (session == null) {
          return left('Nenhuma sessão ativa');
        }

        // Se a sessão ainda é válida, retorna
        if (session.isValid && !session.willExpireSoon) {
          return right(session);
        }

        // Se expirou ou vai expirar em breve, renova
        final refreshResult = await refreshToken(
          refreshToken: session.refreshToken,
        );

        return refreshResult.fold(
          (error) => left(error),
          (newSession) => right(newSession),
        );
      },
    );
  }
}
