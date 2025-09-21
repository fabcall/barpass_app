import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.size = 80,
  });

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: context.colorScheme.surface,
              ),
              padding: const EdgeInsets.all(8),
              child: RiveAnimation.asset(
                'assets/rive-animations/logo-scan.riv',
                fit: BoxFit.contain,
                onInit: (artboard) {
                  final controller = StateMachineController.fromArtboard(
                    artboard,
                    'State Machine 1', // Nome da sua State Machine no Rive
                  );

                  if (controller != null) {
                    artboard.addController(controller);

                    // Encontra o input isDarkMode
                    final isDarkModeInput = controller.findInput<bool>(
                      'isDarkMode',
                    );
                    if (isDarkModeInput != null) {
                      isDarkModeInput.value =
                          context.colorScheme.brightness == Brightness.dark;
                    }
                  }
                },
              ),
            ),
          ),

          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
