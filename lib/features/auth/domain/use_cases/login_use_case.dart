import 'package:barpass_app/features/auth/domain/entities/user.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<String, User>> call({
    required String email,
    required String password,
  }) async {
    // Validações
    if (email.isEmpty) {
      return left('Email é obrigatório');
    }

    if (!_isValidEmail(email)) {
      return left('Email inválido');
    }

    if (password.isEmpty) {
      return left('Senha é obrigatória');
    }

    return _repository.login(email: email, password: password);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
