import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.onPressedFn, required this.onChanged,
  });
  final VoidCallback onPressedFn;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: onPressedFn, icon: const Icon(Iconsax.search_normal)),
          labelText: "Search"),
    );
  }
}
