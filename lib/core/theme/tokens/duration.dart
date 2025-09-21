/// Durações de animação
class AppDuration {
  const AppDuration._();

  static const fast = Duration(milliseconds: 100);
  static const normal = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 300);

  // Contextos
  static const Duration pageTransition = medium;
  static const Duration fadeIn = normal;
}
