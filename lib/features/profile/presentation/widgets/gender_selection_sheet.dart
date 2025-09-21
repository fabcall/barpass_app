import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

enum Gender { female, male, unknown }

Future<Gender?> showGenderSelectionSheet(
  BuildContext context, {
  Gender? initialSelection,
  bool useRootNavigator = true,
}) {
  // Use ModalSheetRoute to show a modal sheet with imperative Navigator API.
  // It works with any *Sheet provided by this package!
  final modalRoute = ModalSheetRoute<Gender>(
    // Enable the swipe-to-dismiss behavior.
    swipeDismissible: true,
    // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
    swipeDismissSensitivity: const SwipeDismissSensitivity(
      minFlingVelocityRatio: 2.0,
      dismissalOffset: SheetOffset.proportionalToViewport(0.4),
    ),
    builder: (context) =>
        _GenderSelectionSheet(initialSelection: initialSelection),
  );

  return Navigator.push(context, modalRoute);
}

class _GenderSelectionSheet extends StatefulWidget {
  const _GenderSelectionSheet({this.initialSelection});

  final Gender? initialSelection;

  @override
  State<_GenderSelectionSheet> createState() => _GenderSelectionSheetState();
}

class _GenderSelectionSheetState extends State<_GenderSelectionSheet> {
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnknownSelected = _selectedGender == Gender.unknown;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selecione seu Gênero',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontFamily: AppTypography.comfortaa,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _GenderOption(
                      gender: Gender.female,
                      label: 'Feminino',
                      icon: Icons.female,
                      color: const Color(0xFFEC407A),
                      isSelected: _selectedGender == Gender.female,
                      onTap: () {
                        setState(() {
                          _selectedGender = Gender.female;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'ou',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _GenderOption(
                      gender: Gender.male,
                      label: 'Masculino',
                      icon: Icons.male,
                      color: const Color(0xFF42A5F5),
                      isSelected: _selectedGender == Gender.male,
                      onTap: () {
                        setState(() {
                          _selectedGender = Gender.male;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedGender = Gender.unknown;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: isUnknownSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Prefiro não responder',
                  style: TextStyle(
                    fontWeight: isUnknownSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _selectedGender != null
                    ? () {
                        context.navigate.pop(_selectedGender);
                      }
                    : null,

                child: const Text(
                  'Salvar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderOption extends StatefulWidget {
  const _GenderOption({
    required this.gender,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Gender gender;
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_GenderOption> createState() => _GenderOptionState();
}

class _GenderOptionState extends State<_GenderOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderRadiusAnimation;

  bool _previouslySelected = false;

  @override
  void initState() {
    super.initState();
    _previouslySelected = widget.isSelected;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 1.15,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.15,
          end: 0.95,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.95,
          end: 1,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    _borderRadiusAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 24,
          end: 16,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 16,
          end: 28,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 28,
          end: 24,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant _GenderOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !_previouslySelected) {
      _controller.forward(from: 0);
    }
    _previouslySelected = widget.isSelected;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const colorChangeDuration = Duration(milliseconds: 200);

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      _borderRadiusAnimation.value,
                    ),
                    color: widget.isSelected
                        ? widget.color
                        : theme.colorScheme.surfaceContainer,
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: widget.color.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      size: 56,
                      color: widget.isSelected ? Colors.white : widget.color,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          AnimatedDefaultTextStyle(
            duration: colorChangeDuration,
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: widget.isSelected
                  ? widget.color
                  : theme.colorScheme.onSurface,
            ),
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }
}

// --- FIM DO CÓDIGO DO GENDER_SELECTION_SHEET ---
