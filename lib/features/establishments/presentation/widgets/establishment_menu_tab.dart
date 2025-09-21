import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstablishmentMenuTab extends StatelessWidget {
  const EstablishmentMenuTab({
    super.key,
    required this.scrollController,
    required this.establishmentId,
  });

  final ScrollController scrollController;
  final String establishmentId;

  @override
  Widget build(BuildContext context) {
    // TODO: Substituir por dados reais do provider
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom, // Padding para safe area
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuSection(
              context,
              'Entradas',
              [
                MenuItemData(
                  'Bruschetta Italiana',
                  'Pão torrado com tomate, manjericão e azeite',
                  'R\$ 18,90',
                ),
                MenuItemData(
                  'Antipasto da Casa',
                  'Seleção de queijos, embutidos e azeitonas',
                  'R\$ 32,90',
                ),
              ],
            ),

            _buildMenuSection(
              context,
              'Pratos Principais',
              [
                MenuItemData(
                  'Spaghetti Carbonara',
                  'Macarrão com bacon, ovos e queijo parmesão',
                  'R\$ 42,90',
                ),
                MenuItemData(
                  'Risotto ai Funghi',
                  'Risoto cremoso com cogumelos porcini',
                  'R\$ 38,90',
                ),
                MenuItemData(
                  'Osso Buco alla Milanese',
                  'Osso buco com risotto açafrão',
                  'R\$ 56,90',
                ),
              ],
            ),

            _buildMenuSection(
              context,
              'Sobremesas',
              [
                MenuItemData(
                  'Tiramisu',
                  'Sobremesa tradicional italiana',
                  'R\$ 16,90',
                ),
                MenuItemData(
                  'Panna Cotta',
                  'Creme italiano com calda de frutas vermelhas',
                  'R\$ 14,90',
                ),
              ],
            ),

            const Gap(50), // Espaço extra para melhor scroll
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<MenuItemData> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        ...items.map((item) => _buildMenuItem(context, item)),
        const Gap(24),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItemData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Text(
            item.price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Model class for menu items
class MenuItemData {
  final String name;
  final String description;
  final String price;

  MenuItemData(this.name, this.description, this.price);
}
