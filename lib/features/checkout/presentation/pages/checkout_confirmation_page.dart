import 'package:barpass_app/core/router/navigation_extension.dart';
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

  // Dados mockados (viriam do parse do QR Code ou API)
  String? establishmentName;
  double? subtotal;
  List<OrderItem>? items;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  Future<void> _loadOrderDetails() async {
    // TODO: Parse QR data ou chamar API para buscar detalhes do pedido
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
      // TODO: Implement actual payment processing
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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEstablishmentCard(theme, colorScheme),
              const Gap(24),
              _buildOrderItems(theme, colorScheme),
              const Gap(24),
              _buildPaymentSummary(theme, colorScheme),
              const Gap(24),
              _buildPaymentMethod(theme, colorScheme),
              const Gap(24),
              _buildWarningBanner(theme, colorScheme),
              const Gap(80), // Espaço para o bottomBar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstablishmentCard(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.store,
              color: colorScheme.onPrimaryContainer,
              size: 28,
            ),
          ),
          const Gap(16),
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
                const Gap(4),
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
            size: 20,
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
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayItems.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              color: colorScheme.outlineVariant.withOpacity(0.5),
            ),
            itemBuilder: (context, index) {
              final item = displayItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
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
                    const Gap(12),
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
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSummaryRow('Subtotal', subtotal ?? 0, theme, colorScheme),
              const Gap(8),
              _buildSummaryRow(
                'Taxa de serviço (10%)',
                serviceCharge,
                theme,
                colorScheme,
              ),
              const Gap(12),
              Divider(color: colorScheme.outlineVariant),
              const Gap(12),
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
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: colorScheme.onPrimaryContainer,
                  size: 20,
                ),
              ),
              const Gap(12),
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
                      'Saldo disponível: R\$ 500,00',
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.secondary.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: colorScheme.onSecondaryContainer,
          ),
          const Gap(12),
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
          const Gap(12),
          Expanded(
            child: FilledButton(
              onPressed: _isProcessing ? null : _confirmPayment,
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
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
