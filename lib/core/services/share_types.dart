/// Resultado da operação de compartilhamento
enum ShareStatus {
  /// Compartilhamento realizado com sucesso
  success,

  /// Usuário cancelou o compartilhamento
  cancelled,

  /// Erro durante o compartilhamento
  error,
}

/// Tipos de conteúdo que podem ser compartilhados
enum ShareContentType {
  text,
  image,
  file,
  establishment,
  custom,
}
