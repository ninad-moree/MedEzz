import 'package:flutter/material.dart';

class TermsAndConditionsCheckBox extends StatelessWidget {
  const TermsAndConditionsCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            onChanged: (value) => {},
            value: false,
          ),
        ),
        const SizedBox(width: 16),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'I agree to ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: 'Privacy Policy ',
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              TextSpan(
                text: 'and ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: 'Terms of Use',
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
