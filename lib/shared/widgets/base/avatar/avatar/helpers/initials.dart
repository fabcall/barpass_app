/// A class that generates initials from a given name.
class Initials {
  /// Creates an instance of [Initials] with the provided [name] and optional parameters.
  ///
  /// The [name] parameter is required and cannot be empty.
  /// Optional parameters:
  /// - [allowSpecialChars]: Specifies whether to allow special characters in the initials. Default is `false`.
  /// - [keepCase]: Specifies whether to keep the original case of the name. Default is `false`.
  /// - [length]: Specifies the desired length of the initials. Default is `2`.
  Initials(
    this.name, {
    this.allowSpecialChars = false,
    this.keepCase = false,
    this.length = 2,
  }) : initials = _generateInitials(name, allowSpecialChars, keepCase, length) {
    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
  }

  /// The generated initials.
  final String initials;

  /// The name from which the initials are generated.
  final String name;

  /// Specifies whether to allow special characters in the initials.
  final bool allowSpecialChars;

  /// Specifies whether to keep the original case of the name.
  final bool keepCase;

  /// Specifies the desired length of the initials.
  final int length;

  /// Generates the initials based on the provided [name] and optional parameters.
  static String _generateInitials(
    String name,
    bool allowSpecialChars,
    bool keepCase,
    int length,
  ) {
    var nameOrInitials = name;

    if (!keepCase) {
      nameOrInitials = nameOrInitials.toUpperCase();
    }

    if (!allowSpecialChars) {
      nameOrInitials = nameOrInitials.replaceAll(
        RegExp(r'[!@#$%^&*(),.?":{}|<>_]'),
        '',
      );
    }

    nameOrInitials = nameOrInitials.trim().replaceAll(RegExp(r'^-+|-+$'), '');

    final names = nameOrInitials
        .split(RegExp('[ -]'))
        .where((element) => element.isNotEmpty)
        .toList();

    var initials = nameOrInitials;
    var assignedNames = 0;

    if (names.length > 1) {
      final buffer = StringBuffer();
      var start = 0;

      for (var i = 0; i < length; i++) {
        var index = i;

        if ((index == (length - 1) && index > 0) ||
            (index > (names.length - 1))) {
          index = names.length - 1;
        }

        if (assignedNames >= names.length) {
          start++;
        }

        final end = start + 1;

        if (names[index].length >= end) {
          buffer.write(names[index].substring(start, end));
        }
        assignedNames++;
      }

      initials = buffer.toString();
    }

    return initials.substring(0, length.clamp(0, initials.length));
  }
}
