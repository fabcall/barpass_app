import 'package:barpass_app/shared/widgets/base/rating/animated_star_rating.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({
    required this.establishmentId,
    super.key,
    this.orderId,
  });

  final String establishmentId;
  final String? orderId;

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  late final ValueNotifier<double> attendanceRating;
  late final ValueNotifier<double> serviceRating;
  late final ValueNotifier<double> environmentRating;
  late final TextEditingController commentController;
  late final ValueNotifier<bool> isFormValid;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    attendanceRating = ValueNotifier(0);
    serviceRating = ValueNotifier(0);
    environmentRating = ValueNotifier(0);
    commentController = TextEditingController();
    isFormValid = ValueNotifier(false);

    // Listener para validar formulário
    attendanceRating.addListener(_validateForm);
    serviceRating.addListener(_validateForm);
    environmentRating.addListener(_validateForm);
  }

  @override
  void dispose() {
    attendanceRating.removeListener(_validateForm);
    serviceRating.removeListener(_validateForm);
    environmentRating.removeListener(_validateForm);

    attendanceRating.dispose();
    serviceRating.dispose();
    environmentRating.dispose();
    commentController.dispose();
    isFormValid.dispose();
    super.dispose();
  }

  void _validateForm() {
    isFormValid.value =
        attendanceRating.value > 0 ||
        serviceRating.value > 0 ||
        environmentRating.value > 0;
  }

  bool get _hasAnyRating =>
      attendanceRating.value > 0 ||
      serviceRating.value > 0 ||
      environmentRating.value > 0;

  Future<void> _submitReview() async {
    if (!_hasAnyRating) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, avalie pelo menos um aspecto'),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar avaliação: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SheetContentScaffold(
      topBar: AppBar(
        title: const Text('Avaliar estabelecimento'),
        centerTitle: true,
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: ValueListenableBuilder<bool>(
        valueListenable: isFormValid,
        builder: (context, isValid, _) {
          return FloatingActionBar(
            child: FilledButton(
              onPressed: _isSubmitting || !isValid ? null : _submitReview,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Enviar Avaliação'),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Como foi sua experiência?',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sua opinião ajuda outros usuários a encontrarem os melhores lugares',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),

            // Rating Sections
            _RatingSection(
              title: 'Atendimento',
              icon: Icons.support_agent,
              ratingNotifier: attendanceRating,
            ),
            const SizedBox(height: 24),

            _RatingSection(
              title: 'Qualidade do Serviço',
              icon: Icons.star_rate,
              ratingNotifier: serviceRating,
            ),
            const SizedBox(height: 24),

            _RatingSection(
              title: 'Ambiente',
              icon: Icons.store,
              ratingNotifier: environmentRating,
            ),
            const SizedBox(height: 32),

            // Comment Section
            Text(
              'Comentário (opcional)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: commentController,
              maxLines: 5,
              maxLength: 500,
              enabled: !_isSubmitting,
              decoration: InputDecoration(
                hintText: 'Conte mais sobre sua experiência...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 80), // Espaço para o bottomBar
          ],
        ),
      ),
    );
  }
}

class _RatingSection extends StatelessWidget {
  const _RatingSection({
    required this.title,
    required this.icon,
    required this.ratingNotifier,
  });

  final String title;
  final IconData icon;
  final ValueNotifier<double> ratingNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<double>(
          valueListenable: ratingNotifier,
          builder: (context, rating, _) {
            return Column(
              children: [
                DraggableStarRating(
                  initialRating: rating,
                  onRatingChanged: (newRating) {
                    ratingNotifier.value = newRating;
                  },
                  minRating: 0.0,
                ),
                const SizedBox(height: 8),
                Text(
                  _getRatingLabel(rating),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _getRatingLabel(double rating) {
    if (rating == 0) return 'Toque para avaliar';
    if (rating <= 1) return 'Muito ruim';
    if (rating <= 2) return 'Ruim';
    if (rating <= 3) return 'Regular';
    if (rating <= 4) return 'Bom';
    return 'Excelente';
  }
}
