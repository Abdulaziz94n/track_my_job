import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_extension.dart';
import 'app_text.dart';

class ScreenTitleText extends StatelessWidget {
  const ScreenTitleText({super.key, required this.text, this.action});
  final String text;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AppText(
            text: text,
            style: context.appTextTheme.titleLarge!,
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}
