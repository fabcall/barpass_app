import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Shell customizado para modal sheets de autenticação
class SheetShell extends StatelessWidget {
  const SheetShell({required this.navigator, super.key});

  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    final materialSheetDecoration = MaterialSheetDecoration(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      color: ColorScheme.of(context).surface,
      size: SheetSize.fit,
    );

    return PagedSheet(
      decoration: materialSheetDecoration,
      builder: (context, child) {
        return SheetContentScaffold(
          body: child,
        );
      },
      navigator: navigator,
    );
  }
}
