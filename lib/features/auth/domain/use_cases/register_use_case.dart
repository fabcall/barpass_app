import 'package:barpass_app/features/auth/domain/entities/user.dart';
import 'package:barpass_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUseCase {
  RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<String, User>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    // Validações
    if (name.isEmpty) {
      return left('Nome é obrigatório');
    }

    if (email.isEmpty) {
      return left('Email é obrigatório');
    }

    if (!_isValidEmail(email)) {
      return left('Email inválido');
    }

    if (password.isEmpty) {
      return left('Senha é obrigatória');
    }

    if (password.length < 8) {
      return left('Senha deve ter pelo menos 8 caracteres');
    }

    if (!_isStrongPassword(password)) {
      return left('Senha deve conter: 1 maiúscula, 1 minúscula e 1 número');
    }

    return _repository.register(
      name: name,
      email: email,
      password: password,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password);
  }
}
