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
  // Constantes específicas do QR Scanner
  static const _scanAreaSize = 250.0;
  static const _cornerLength = 20.0;
  static const _cornerWidth = 4.0;
  static const _scanLineWidth = 2.0;

  late MobileScannerController controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    controller = MobileScannerController(
      autoStart: false,
    );

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

    _animationController.repeat(reverse: true);

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

        if (!mounted) {
          return;
        }

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
                ? context.colorScheme.primary.withValues(
                    alpha: AppOpacity.strong,
                  )
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      margin: AppSpacing.pagePadding,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),
          _buildScanOverlay(),
          Positioned(
            bottom: AppSpacing.xl,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.componentGap,
                horizontal: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: AppOpacity.overlay,
                ),
                borderRadius: AppRadius.borderMd,
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
            scanAreaSize: _scanAreaSize,
            cornerLength: _cornerLength,
            cornerWidth: _cornerWidth,
            scanLineWidth: _scanLineWidth,
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

class _ScanOverlayPainter extends CustomPainter {
  _ScanOverlayPainter({
    required this.colorScheme,
    required this.animationValue,
    required this.scanAreaSize,
    required this.cornerLength,
    required this.cornerWidth,
    required this.scanLineWidth,
  });

  final ColorScheme colorScheme;
  final double animationValue;
  final double scanAreaSize;
  final double cornerLength;
  final double cornerWidth;
  final double scanLineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: AppOpacity.semiTransparent)
      ..style = PaintingStyle.fill;

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

    final cornerPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    // Cantos
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
      horizontalRect = Rect.fromLTWH(corner.dx, corner.dy, length, width);
      verticalRect = Rect.fromLTWH(corner.dx, corner.dy, width, length);
    } else if (isTop && !isLeft) {
      horizontalRect = Rect.fromLTWH(
        corner.dx - length,
        corner.dy,
        length,
        width,
      );
      verticalRect = Rect.fromLTWH(corner.dx - width, corner.dy, width, length);
    } else if (!isTop && isLeft) {
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

  void _drawScanLine(Canvas canvas, Rect scanAreaRect) {
    final lineY = scanAreaRect.top + (scanAreaRect.height * animationValue);
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = scanLineWidth
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
