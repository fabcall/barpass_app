import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/widgets/layout/floating_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class CheckoutConfirmationPage extends StatefulWidget {
  const CheckoutConfirmationPage({
    required this.establishmentId,
    super.key,
    this.orderId,
  });

  final String establishmentId;
  final String? orderId;

  @override
  State<CheckoutConfirmationPage> createState() =>
      _CheckoutConfirmationPageState();
}

class _CheckoutConfirmationPageState extends State<CheckoutConfirmationPage> {
  bool _isProcessing = false;

  String? establishmentName;
  double? subtotal;
  List<OrderItem>? items;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  Future<void> _loadOrderDetails() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        establishmentName = 'Bar do João';
        subtotal = 125.50;
        items = [
          const OrderItem(name: 'Cerveja Heineken', quantity: 3, price: 15),
          const OrderItem(name: 'Porção de Batata', quantity: 1, price: 35),
          const OrderItem(name: 'Caipirinha', quantity: 2, price: 18),
          const OrderItem(name: 'Água', quantity: 2, price: 5),
        ];
      });
    }
  }

  double get serviceCharge => (subtotal ?? 0) * 0.1;
  double get total => (subtotal ?? 0) + serviceCharge;

  Future<void> _confirmPayment() async {
    setState(() => _isProcessing = true);

    try {
      await Future<void>.delayed(const Duration(seconds: 2));

      if (mounted) {
        context.navigate.pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao processar pagamento: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isLoading = establishmentName == null;

    return SheetContentScaffold(
      topBar: AppBar(
        title: const Text('Confirmar consumo'),
        centerTitle: true,
      ),
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      bottomBar: _buildBottomBar(),
      body: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEstablishmentCard(theme, colorScheme),
              const Gap(AppSpacing.sectionGap),
              _buildOrderItems(theme, colorScheme),
              const Gap(AppSpacing.sectionGap),
              _buildPaymentSummary(theme, colorScheme),
              const Gap(AppSpacing.sectionGap),
              _buildPaymentMethod(theme, colorScheme),
              const Gap(AppSpacing.sectionGap),
              _buildWarningBanner(theme, colorScheme),
              const Gap(AppSpacing.sectionGap + AppSizes.componentHeightLg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstablishmentCard(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.borderLg,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.imageMd,
            height: AppSizes.imageMd,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: AppRadius.borderMd,
            ),
            child: Icon(
              Icons.store,
              color: colorScheme.onPrimaryContainer,
              size: AppSizes.iconLg,
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  establishmentName ?? 'Nome do Estabelecimento',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  'ID: ${widget.establishmentId}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.verified,
            color: colorScheme.primary,
            size: AppSizes.iconSm,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(ThemeData theme, ColorScheme colorScheme) {
    final displayItems =
        items ??
        List.generate(
          3,
          (index) => const OrderItem(
            name: 'Item do Pedido',
            quantity: 1,
            price: 15,
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Itens do pedido',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.componentGap),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.borderMd,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayItems.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              color: colorScheme.outlineVariant.withValues(
                alpha: AppOpacity.semiTransparent,
              ),
            ),
            itemBuilder: (context, index) {
              final item = displayItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.componentGap,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.itemGap,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item.quantity}x',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.componentGap),
                    Expanded(
                      child: Text(
                        item.name,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      'R\$ ${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumo',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.componentGap),
        Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.borderMd,
          ),
          child: Column(
            children: [
              _buildSummaryRow('Subtotal', subtotal ?? 0, theme, colorScheme),
              const Gap(AppSpacing.itemGap),
              _buildSummaryRow(
                'Taxa de serviço (10%)',
                serviceCharge,
                theme,
                colorScheme,
              ),
              const Gap(AppSpacing.componentGap),
              Divider(color: colorScheme.outlineVariant),
              const Gap(AppSpacing.componentGap),
              _buildSummaryRow(
                'Total',
                total,
                theme,
                colorScheme,
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    double value,
    ThemeData theme,
    ColorScheme colorScheme, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? colorScheme.primary : null,
          ),
        ),
        Text(
          'R\$ ${value.toStringAsFixed(2)}',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? colorScheme.primary : null,
            fontSize: isTotal ? 18 : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Método de pagamento',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.componentGap),
        Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.borderMd,
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: AppOpacity.heavy),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.componentHeightSm,
                height: AppSizes.componentHeightSm,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: AppRadius.borderSm,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: colorScheme.onPrimaryContainer,
                  size: AppSizes.iconSm,
                ),
              ),
              const Gap(AppSpacing.componentGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo BarPass',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      r'Saldo disponível: R$ 500,00',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWarningBanner(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(
          alpha: AppOpacity.semiTransparent,
        ),
        borderRadius: AppRadius.borderMd,
        border: Border.all(
          color: colorScheme.secondary.withValues(alpha: AppOpacity.heavy),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: AppSizes.iconSm,
            color: colorScheme.onSecondaryContainer,
          ),
          const Gap(AppSpacing.componentGap),
          Expanded(
            child: Text(
              'Ao confirmar, o pagamento será processado imediatamente e o valor será debitado do seu saldo BarPass',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return FloatingActionBar(
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isProcessing ? null : () => context.navigate.pop(),
              child: const Text('Cancelar'),
            ),
          ),
          const Gap(AppSpacing.componentGap),
          Expanded(
            child: FilledButton(
              onPressed: _isProcessing ? null : _confirmPayment,
              child: _isProcessing
                  ? const SizedBox(
                      height: AppSizes.iconSm,
                      width: AppSizes.iconSm,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem {
  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final int quantity;
  final double price;
}
