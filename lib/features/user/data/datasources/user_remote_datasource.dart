import 'package:barpass_app/features/user/data/models/user_model.dart';

/// Interface para DataSource remoto de usuário
abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser(String userId);
  Future<UserModel> getUserById(String userId);
  Future<UserModel> updateProfile({
    required String userId,
    String? name,
    String? avatarUrl,
    String? phoneNumber,
  });
  Future<String> uploadAvatar({
    required String userId,
    required String filePath,
  });
  Future<void> deleteAccount(String userId);
  Future<void> verifyEmail({
    required String userId,
    required String code,
  });
  Future<void> verifyPhone({
    required String userId,
    required String code,
  });
  Future<void> updatePreferences({
    required String userId,
    required Map<String, dynamic> preferences,
  });
}

/// Implementação do DataSource remoto para operações de usuário
///
/// Em produção, se comunicaria com o backend via HTTP/Dio.
/// Por enquanto, simula chamadas de API.
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this._usersDatabase);

  // Referência ao "banco de dados" do AuthRemoteDataSource
  final Map<String, Map<String, dynamic>> _usersDatabase;

  @override
  Future<UserModel> getCurrentUser(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    final userData = userEntry.value;

    return UserModel(
      id: userData['id'] as String,
      email: userEntry.key,
      name: userData['name'] as String,
      avatarUrl: userData['avatarUrl'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      isEmailVerified: userData['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: userData['isPhoneVerified'] as bool? ?? false,
      createdAt: userData['createdAt'] as DateTime?,
      lastLoginAt: DateTime.now(),
    );
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    final userData = userEntry.value;

    return UserModel(
      id: userData['id'] as String,
      email: userEntry.key,
      name: userData['name'] as String,
      avatarUrl: userData['avatarUrl'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      isEmailVerified: userData['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: userData['isPhoneVerified'] as bool? ?? false,
      createdAt: userData['createdAt'] as DateTime?,
      lastLoginAt: userData['lastLoginAt'] as DateTime?,
    );
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? name,
    String? avatarUrl,
    String? phoneNumber,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    final userData = userEntry.value;

    if (name != null) userData['name'] = name;
    if (avatarUrl != null) userData['avatarUrl'] = avatarUrl;
    if (phoneNumber != null) userData['phoneNumber'] = phoneNumber;

    return UserModel(
      id: userData['id'] as String,
      email: userEntry.key,
      name: userData['name'] as String,
      avatarUrl: userData['avatarUrl'] as String?,
      phoneNumber: userData['phoneNumber'] as String?,
      isEmailVerified: userData['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: userData['isPhoneVerified'] as bool? ?? false,
      createdAt: userData['createdAt'] as DateTime?,
      lastLoginAt: userData['lastLoginAt'] as DateTime?,
    );
  }

  @override
  Future<String> uploadAvatar({
    required String userId,
    required String filePath,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final avatarUrl =
        'https://cdn.example.com/avatars/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    userEntry.value['avatarUrl'] = avatarUrl;

    // ignore: avoid_print
    print('📸 Avatar atualizado: $avatarUrl');

    return avatarUrl;
  }

  @override
  Future<void> deleteAccount(String userId) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _usersDatabase.removeWhere((key, value) => value['id'] == userId);

    // ignore: avoid_print
    print('🗑️ Conta deletada para userId: $userId');
  }

  @override
  Future<void> verifyEmail({
    required String userId,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    userEntry.value['isEmailVerified'] = true;

    // ignore: avoid_print
    print('✅ Email verificado para userId: $userId');
  }

  @override
  Future<void> verifyPhone({
    required String userId,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    userEntry.value['isPhoneVerified'] = true;

    // ignore: avoid_print
    print('✅ Telefone verificado para userId: $userId');
  }

  @override
  Future<void> updatePreferences({
    required String userId,
    required Map<String, dynamic> preferences,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final userEntry = _usersDatabase.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => throw Exception('Usuário não encontrado'),
    );

    userEntry.value['preferences'] = preferences;

    // ignore: avoid_print
    print('⚙️ Preferências atualizadas para userId: $userId');
  }
}
