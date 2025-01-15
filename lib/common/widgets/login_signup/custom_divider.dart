import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TCustomDivider extends StatelessWidget {
  const TCustomDivider({
    super.key, required this.dividerText,
  });
  final String dividerText; 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(child: Divider(color: TColors.primary,thickness: 0.5, indent: 60, endIndent: 5,)),
        Text(dividerText , style: Theme.of(context).textTheme.labelMedium,),
        const Flexible(child: Divider(color: TColors.primary,thickness: 0.5, indent: 5, endIndent: 60,)),
      ],
    );
  }
}