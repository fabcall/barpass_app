import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with TickerProviderStateMixin {
  MobileScannerController controller = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isFlashOn = false;
  String? result;
  bool hasScanned = false;

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (hasScanned) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      if (barcode.rawValue != null) {
        setState(() {
          result = barcode.rawValue;
          hasScanned = true;
        });

        // Parar animação quando encontrar resultado
        _animationController.stop();

        // Vibração de feedback
        HapticFeedback.mediumImpact();

        // Pausa a câmera
        controller.stop();
      }
    }
  }

  Future<void> _toggleFlash() async {
    try {
      await controller.toggleTorch();
      setState(() {
        isFlashOn = !isFlashOn;
      });
    } on Exception catch (_) {
      // Ignore flash errors
    }
  }

  void _resetScanner() {
    setState(() {
      result = null;
      hasScanned = false;
    });

    // Reiniciar animação
    _animationController.repeat(reverse: true);
    controller.start();
  }

  void _copyToClipboard() {
    if (result != null) {
      Clipboard.setData(ClipboardData(text: result!));
      Burnt().toast(
        context,
        title: 'Copiado para a área de transferência',
        preset: BurntPreset.done,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: _buildHeader(context),
      bottomBar: _buildFooter(),
      body: Material(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              // Scanner ou resultado
              Expanded(
                child: result != null
                    ? _buildResultView()
                    : _buildScannerView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppBar(
      actions: [
        if (result == null)
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
          )
        else
          const SizedBox(width: 48), // Para manter o alinhamento
      ],
    );
  }

  Widget _buildScannerView() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Scanner
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),

          // Overlay com área de scan
          _buildScanOverlay(),

          // Instruções
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

  Widget _buildResultView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícone de sucesso
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
          ),

          const Gap(24),

          Text(
            'QR Code escaneado!',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const Gap(16),

          // Resultado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Resultado:',
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _copyToClipboard,
                      icon: const Icon(Icons.copy, size: 18),
                      tooltip: 'Copiar',
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        foregroundColor: context.colorScheme.primary,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),

                const Gap(8),

                SelectableText(
                  result ?? '',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: context.viewPadding.bottom + 24,
      ),
      child: Row(
        children: [
          if (result != null) ...[
            // Escanear novamente
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _resetScanner,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Escanear novamente'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const Gap(12),

            // Usar resultado
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  // TODO: Implementar ação com o resultado
                  context.pop(result);
                },
                icon: const Icon(Icons.check),
                label: const Text('Usar'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ] else ...[
            // Apenas o botão de fechar quando escaneando
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ],
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

    // Tamanho da área de scan (quadrado centralizado)
    const scanAreaSize = 250.0;
    final scanAreaRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    // Criar path para a área escura ao redor do scanner
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(scanAreaRect, const Radius.circular(12)),
      )
      ..fillType = PathFillType.evenOdd;

    // Desenhar overlay escuro
    canvas.drawPath(overlayPath, paint);

    // Desenhar bordas do scanner (apenas cantos)
    const cornerLength = 20.0;
    final cornerPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Cantos superiores
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.topLeft,
      cornerLength,
      true,
      true,
    );
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.topRight,
      cornerLength,
      false,
      true,
    );

    // Cantos inferiores
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.bottomLeft,
      cornerLength,
      true,
      false,
    );
    _drawCorner(
      canvas,
      cornerPaint,
      scanAreaRect.bottomRight,
      cornerLength,
      false,
      false,
    );

    // Desenhar linha vermelha animada
    _drawScanLine(canvas, scanAreaRect);
  }

  void _drawScanLine(Canvas canvas, Rect scanAreaRect) {
    // Calcular posição Y da linha baseada na animação
    final lineY = scanAreaRect.top + (scanAreaRect.height * animationValue);

    // Paint para a linha vermelha
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Paint para o gradiente da linha (efeito de brilho)
    final gradientPaint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.transparent,
              Colors.red.withValues(alpha: 0.3),
              Colors.red,
              Colors.red.withValues(alpha: 0.3),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
          ).createShader(
            Rect.fromLTRB(
              scanAreaRect.left,
              lineY - 10,
              scanAreaRect.right,
              lineY + 10,
            ),
          )
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // Desenhar gradiente da linha (efeito de brilho)
    canvas
      ..drawLine(
        Offset(scanAreaRect.left + 10, lineY),
        Offset(scanAreaRect.right - 10, lineY),
        gradientPaint,
      )
      // Desenhar linha principal
      ..drawLine(
        Offset(scanAreaRect.left + 10, lineY),
        Offset(scanAreaRect.right - 10, lineY),
        linePaint,
      );

    // Adicionar pequenos pontos nas extremidades da linha
    final dotPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas
      ..drawCircle(
        Offset(scanAreaRect.left + 10, lineY),
        2,
        dotPaint,
      )
      ..drawCircle(
        Offset(scanAreaRect.right - 10, lineY),
        2,
        dotPaint,
      );
  }

  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    double length,
    bool isLeft,
    bool isTop,
  ) {
    final horizontalStart = isLeft
        ? corner
        : Offset(corner.dx - length, corner.dy);
    final horizontalEnd = isLeft
        ? Offset(corner.dx + length, corner.dy)
        : corner;

    final verticalStart = isTop
        ? corner
        : Offset(corner.dx, corner.dy - length);
    final verticalEnd = isTop ? Offset(corner.dx, corner.dy + length) : corner;

    canvas
      ..drawLine(horizontalStart, horizontalEnd, paint)
      ..drawLine(verticalStart, verticalEnd, paint);
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
