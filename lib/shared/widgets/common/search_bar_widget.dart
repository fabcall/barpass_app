import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final VoidCallback? onSearch;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Buscar evento',
    this.onTap,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
      onTap: onTap,
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
        ),
      ],
    );
  }
}
