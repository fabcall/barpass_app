import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late MobileScannerController controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // Inicializar controller com autoStart false
    controller = MobileScannerController(
      autoStart: false,
    );

    // Configurar animação da linha do scanner
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    // Iniciar animação em loop
    _animationController.repeat(reverse: true);

    // Iniciar scanner após o build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.start();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Se o app for retomado, reinicie o scanner se não estiver rodando
    if (state == AppLifecycleState.resumed) {
      if (!controller.value.isStarting) {
        controller.start();
      }
      if (!_animationController.isAnimating) {
        _animationController.repeat(reverse: true);
      }
    }
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      if (barcode.rawValue != null) {
        _animationController.stop();

        await controller.stop();

        HapticFeedback.mediumImpact();

        final checkoutWasSuccessful = await context.navigate.modal.pushCheckout(
          orderId: 'some-order-id-from-qr',
        );

        if (!mounted) return;

        if (checkoutWasSuccessful ?? false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.navigate.pop(checkoutWasSuccessful);
          });
        } else {
          controller.start();
          _animationController.repeat(reverse: true);
        }
      }
    }
  }

  Future<void> _toggleFlash() async {
    try {
      await controller.toggleTorch();
      setState(() {
        isFlashOn = !isFlashOn;
      });
    } on Exception catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: _buildHeader(context),
      bottomBar: _buildFooter(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
        ),
        child: _buildScannerView(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: _toggleFlash,
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
          ),
          style: IconButton.styleFrom(
            backgroundColor: isFlashOn
                ? context.colorScheme.primary.withValues(alpha: 0.2)
                : null,
            foregroundColor: isFlashOn ? context.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }

  Widget _buildScannerView() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      margin: const EdgeInsets.all(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Scanner
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),

          _buildScanOverlay(),

          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.7,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Posicione o QR Code dentro da área indicada',
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanOverlay() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ScanOverlayPainter(
            colorScheme: context.colorScheme,
            animationValue: _animation.value,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  Widget _buildFooter() {
    return FloatingActionBar(
      child: OutlinedButton(
        onPressed: context.navigate.pop,
        child: const Text('Cancelar'),
      ),
    );
  }
}

// Painter para o overlay do scanner com linha animada
class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter({
    required this.colorScheme,
    required this.animationValue,
  });

  final ColorScheme colorScheme;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    const scanAreaSize = 250.0;
    final scanAreaRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(scanAreaRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlayPath, paint);

    const cornerLength = 20.0;
    const cornerWidth = 4.0;

    final cornerPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    // Cantos superiores
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.topLeft,
      cornerLength,
      cornerWidth,
      isLeft: true,
      isTop: true,
    );
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.topRight,
      cornerLength,
      cornerWidth,
      isLeft: false,
      isTop: true,
    );

    // Cantos inferiores
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.bottomLeft,
      cornerLength,
      cornerWidth,
      isLeft: true,
      isTop: false,
    );
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.bottomRight,
      cornerLength,
      cornerWidth,
      isLeft: false,
      isTop: false,
    );

    _drawScanLine(canvas, scanAreaRect);
  }

  // 👇 MÉTODO CORRIGIDO E SIMPLIFICADO 👇
  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    double length,
    double width, {
    required bool isLeft,
    required bool isTop,
  }) {
    Rect horizontalRect;
    Rect verticalRect;

    if (isTop && isLeft) {
      // Canto Superior Esquerdo
      horizontalRect = Rect.fromLTWH(corner.dx, corner.dy, length, width);
      verticalRect = Rect.fromLTWH(corner.dx, corner.dy, width, length);
    } else if (isTop && !isLeft) {
      // Canto Superior Direito
      horizontalRect = Rect.fromLTWH(
        corner.dx - length,
        corner.dy,
        length,
        width,
      );
      verticalRect = Rect.fromLTWH(corner.dx - width, corner.dy, width, length);
    } else if (!isTop && isLeft) {
      // Canto Inferior Esquerdo
      horizontalRect = Rect.fromLTWH(
        corner.dx,
        corner.dy - width,
        length,
        width,
      );
      verticalRect = Rect.fromLTWH(
        corner.dx,
        corner.dy - length,
        width,
        length,
      );
    } else {
      // Canto Inferior Direito
      horizontalRect = Rect.fromLTWH(
        corner.dx - length,
        corner.dy - width,
        length,
        width,
      );
      verticalRect = Rect.fromLTWH(
        corner.dx - width,
        corner.dy - length,
        width,
        length,
      );
    }

    canvas.drawRect(horizontalRect, paint);
    canvas.drawRect(verticalRect, paint);
  }

  // O método _drawScanLine permanece o mesmo
  void _drawScanLine(Canvas canvas, Rect scanAreaRect) {
    final lineY = scanAreaRect.top + (scanAreaRect.height * animationValue);
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(scanAreaRect.left, lineY),
      Offset(scanAreaRect.right, lineY),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
