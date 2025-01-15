import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(
          width: TSizes.spcBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: TText.isAgree,
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: ' ${TText.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: TColors.primary)),
          TextSpan(
              text: TText.and,
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: ' ${TText.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: TColors.primary)),
        ]
        )
      )
      ],
    );
  }
}