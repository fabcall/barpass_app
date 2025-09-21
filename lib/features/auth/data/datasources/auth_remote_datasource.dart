import 'package:barpass_app/features/auth/data/models/auth_session_model.dart';

/// Interface para DataSource remoto de autenticação
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<AuthSessionModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthSessionModel> refreshToken({
    required String refreshToken,
  });

  Future<bool> validateAccessToken({
    required String accessToken,
  });

  Future<void> logout({required String userId});

  Future<void> sendPasswordResetCode({required String email});

  Future<String> verifyOtp({
    required String email,
    required String code,
  });

  Future<void> changePassword({
    required String token,
    required String newPassword,
  });

  void seedTestUsers();

  /// Expõe o banco de dados para outros datasources (apenas para mock)
  /// Em produção, isso não seria necessário
  Map<String, Map<String, dynamic>> get usersDatabase;
}

/// Implementação do DataSource remoto para operações de autenticação
///
/// Em produção, este DataSource se comunicaria com o backend via HTTP/Dio.
/// Por enquanto, simula chamadas de API com delays.

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Simulando banco de dados (em produção seria removido)
  final Map<String, Map<String, dynamic>> _users = {};
  final Map<String, String> _otpCodes = {};
  final Map<String, String> _resetTokens = {};
  final Map<String, AuthSessionModel> _activeSessions = {};
  final Map<String, String> _refreshTokenToUserId = {};

  /// Gera um access token único
  String _generateAccessToken(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'access_${userId}_$timestamp';
  }

  /// Gera um refresh token único
  String _generateRefreshToken(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'refresh_${userId}_$timestamp';
  }

  /// Cria uma nova sessão para o usuário
  AuthSessionModel _createSession(String userId) {
    final now = DateTime.now();
    final accessToken = _generateAccessToken(userId);
    final refreshToken = _generateRefreshToken(userId);
    final expiresAt = now.add(const Duration(hours: 1));

    final session = AuthSessionModel(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      createdAt: now,
    );

    _activeSessions[userId] = session;
    _refreshTokenToUserId[refreshToken] = userId;

    // ignore: avoid_print
    print('🔑 Nova sessão criada para userId: $userId');
    // ignore: avoid_print
    print('   Access Token: $accessToken');
    // ignore: avoid_print
    print('   Refresh Token: $refreshToken');
    // ignore: avoid_print
    print('   Expira em: $expiresAt');

    return session;
  }

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final userData = _users[email];
    if (userData == null) {
      throw Exception('Usuário não encontrado');
    }

    if (userData['password'] != password) {
      throw Exception('Senha incorreta');
    }

    final userId = userData['id'] as String;
    return _createSession(userId);
  }

  @override
  Future<AuthSessionModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (_users.containsKey(email)) {
      throw Exception('Este email já está cadastrado');
    }

    if (name.isEmpty) {
      throw Exception('Nome é obrigatório');
    }

    if (password.length < 8) {
      throw Exception('Senha deve ter pelo menos 8 caracteres');
    }

    final userId = DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now();

    _users[email] = {
      'id': userId,
      'name': name,
      'email': email,
      'password': password,
      'avatarUrl': null,
      'phoneNumber': null,
      'isEmailVerified': false,
      'isPhoneVerified': false,
      'createdAt': now,
    };

    return _createSession(userId);
  }

  @override
  Future<AuthSessionModel> refreshToken({
    required String refreshToken,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userId = _refreshTokenToUserId[refreshToken];
    if (userId == null) {
      throw Exception('Refresh token inválido');
    }

    final userEmail = _users.entries
        .firstWhere(
          (entry) => entry.value['id'] == userId,
          orElse: () => const MapEntry('', {}),
        )
        .key;

    if (userEmail.isEmpty) {
      throw Exception('Usuário não encontrado');
    }

    _refreshTokenToUserId.remove(refreshToken);
    final newSession = _createSession(userId);

    // ignore: avoid_print
    print('🔄 Token renovado com sucesso para userId: $userId');

    return newSession;
  }

  @override
  Future<bool> validateAccessToken({
    required String accessToken,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    for (final session in _activeSessions.values) {
      if (session.accessToken == accessToken) {
        return !session.toEntity().isExpired;
      }
    }

    return false;
  }

  @override
  Future<void> logout({required String userId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final session = _activeSessions[userId];
    if (session != null) {
      _refreshTokenToUserId.remove(session.refreshToken);
      _activeSessions.remove(userId);
    }

    // ignore: avoid_print
    print('👋 Logout realizado para userId: $userId');
  }

  @override
  Future<void> sendPasswordResetCode({required String email}) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!_users.containsKey(email)) {
      throw Exception('Email não encontrado');
    }

    final code = (100000 + (900000 * (DateTime.now().millisecond / 1000)))
        .floor()
        .toString();
    _otpCodes[email] = code;

    // ignore: avoid_print
    print('🔐 Código de recuperação para $email: $code');
  }

  @override
  Future<String> verifyOtp({
    required String email,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final storedCode = _otpCodes[email];
    if (storedCode == null) {
      throw Exception('Código expirado. Solicite um novo código');
    }

    if (storedCode != code) {
      throw Exception('Código inválido');
    }

    final token = 'reset_${DateTime.now().millisecondsSinceEpoch}';
    _resetTokens[email] = token;
    _otpCodes.remove(email);

    return token;
  }

  @override
  Future<void> changePassword({
    required String token,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    String? email;
    _resetTokens.forEach((key, value) {
      if (value == token) {
        email = key;
      }
    });

    if (email == null) {
      throw Exception('Token inválido ou expirado');
    }

    final userData = _users[email];
    if (userData == null) {
      throw Exception('Usuário não encontrado');
    }

    if (newPassword.length < 8) {
      throw Exception('Senha deve ter pelo menos 8 caracteres');
    }

    userData['password'] = newPassword;
    _resetTokens.remove(email);

    final userId = userData['id'] as String;
    await logout(userId: userId);
  }

  @override
  void seedTestUsers() {
    _users['teste@barpass.com'] = {
      'id': 'user_001',
      'name': 'Usuário Teste',
      'email': 'teste@barpass.com',
      'password': 'Teste123',
      'avatarUrl':
          'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/50/50822cf4ff3422af9b4b7fc7861363477f4351c5_full.jpg',
      'phoneNumber': '+55 11 98765-4321',
      'isEmailVerified': true,
      'isPhoneVerified': true,
      'createdAt': DateTime(2024),
    };
  }

  @override
  Map<String, Map<String, dynamic>> get usersDatabase => _users;
}
