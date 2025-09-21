import 'package:barpass_app/features/auth/domain/entities/user.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Simulando armazenamento em memória
  final Map<String, Map<String, dynamic>> _users = {};
  final Map<String, String> _otpCodes = {};
  final Map<String, String> _resetTokens = {};
  User? _currentUser;

  @override
  Future<Either<String, User>> login({
    required String email,
    required String password,
  }) async {
    // Simula delay de rede
    await Future<void>.delayed(const Duration(seconds: 2));

    // Valida credenciais
    final userData = _users[email];
    if (userData == null) {
      return left('Usuário não encontrado');
    }

    if (userData['password'] != password) {
      return left('Senha incorreta');
    }

    final user = User(
      id: userData['id'] as String,
      email: email,
      name: userData['name'] as String,
      avatarUrl: userData['avatarUrl'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      isEmailVerified: userData['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: userData['isPhoneVerified'] as bool? ?? false,
      createdAt: userData['createdAt'] as DateTime?,
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    return right(user);
  }

  @override
  Future<Either<String, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    // Verifica se email já existe
    if (_users.containsKey(email)) {
      return left('Este email já está cadastrado');
    }

    // Validações
    if (name.isEmpty) {
      return left('Nome é obrigatório');
    }

    if (password.length < 8) {
      return left('Senha deve ter pelo menos 8 caracteres');
    }

    final userId = DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now();

    _users[email] = {
      'id': userId,
      'name': name,
      'password': password,
      'avatarUrl': null,
      'phoneNumber': null,
      'isEmailVerified': false,
      'isPhoneVerified': false,
      'createdAt': now,
    };

    final user = User(
      id: userId,
      email: email,
      name: name,
      createdAt: now,
      lastLoginAt: now,
    );

    _currentUser = user;
    return right(user);
  }

  @override
  Future<Either<String, void>> sendPasswordResetCode({
    required String email,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!_users.containsKey(email)) {
      return left('Email não encontrado');
    }

    // Gera código de 6 dígitos
    final code = (100000 + (900000 * (DateTime.now().millisecond / 1000)))
        .floor()
        .toString();
    _otpCodes[email] = code;

    // Em produção, você enviaria o email aqui
    // ignore: avoid_print
    print('🔐 Código de recuperação para $email: $code');

    return right(null);
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final storedCode = _otpCodes[email];
    if (storedCode == null) {
      return left('Código expirado. Solicite um novo código');
    }

    if (storedCode != code) {
      return left('Código inválido');
    }

    // Gera token de reset
    final token = 'reset_${DateTime.now().millisecondsSinceEpoch}';
    _resetTokens[email] = token;

    // Remove o código usado
    _otpCodes.remove(email);

    return right(token);
  }

  @override
  Future<Either<String, void>> changePassword({
    required String token,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    // Encontra o email pelo token
    String? email;
    _resetTokens.forEach((key, value) {
      if (value == token) {
        email = key;
      }
    });

    if (email == null) {
      return left('Token inválido ou expirado');
    }

    final userData = _users[email];
    if (userData == null) {
      return left('Usuário não encontrado');
    }

    // Valida nova senha
    if (newPassword.length < 8) {
      return left('Senha deve ter pelo menos 8 caracteres');
    }

    // Atualiza senha
    userData['password'] = newPassword;

    // Remove token usado
    _resetTokens.remove(email);

    return right(null);
  }

  @override
  Future<Either<String, void>> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    return right(null);
  }

  @override
  Future<Either<String, User?>> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return right(_currentUser);
  }

  // Método auxiliar para criar usuários de teste
  void seedTestUsers() {
    _users['teste@barpass.com'] = {
      'id': 'user_001',
      'name': 'Usuário Teste',
      'password': 'Teste123',
      'avatarUrl':
          'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/50/50822cf4ff3422af9b4b7fc7861363477f4351c5_full.jpg',
      'phoneNumber': '+55 11 98765-4321',
      'isEmailVerified': true,
      'isPhoneVerified': true,
      'createdAt': DateTime(2024),
    };
  }
}
