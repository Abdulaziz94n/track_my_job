import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_extension.dart';
import '../../core/theme/decorations.dart';
import 'app_text.dart';

class AppTextField extends StatelessWidget {
  const AppTextField.withController(
      {super.key,
      required this.controller,
      required this.label,
      this.enabled,
      this.onTap,
      this.prefixIcon,
      this.maxLines,
      this.fontSize,
      this.inputType,
      this.onChanged,
      this.isDense,
      this.initialValue,
      this.contentPadding,
      this.validator});
  final TextEditingController? controller;
  final bool? enabled;
  final String label;
  final Widget? prefixIcon;
  final int? maxLines;
  final double? fontSize;
  final EdgeInsets? contentPadding;
  final bool? isDense;
  final String? initialValue;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onTap;

  const AppTextField.withOnChanged(
      {super.key,
      required this.onChanged,
      required this.label,
      this.enabled,
      this.onTap,
      this.prefixIcon,
      this.maxLines,
      this.fontSize,
      this.inputType,
      this.isDense,
      this.initialValue,
      this.contentPadding,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onTap: onTap,
        initialValue: initialValue,
        enabled: enabled,
        controller: controller,
        style: fontSize != null
            ? TextStyle(fontSize: fontSize)
            : context.appTextTheme.bodyLarge!
                .copyWith(color: Colors.grey.shade600),
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        keyboardType: inputType,
        maxLines: maxLines ?? 1,
        validator: validator,
        decoration: WidgetsDecoration.textFieldDecoration((context)).copyWith(
          label: AppText(
            text: label,
            style: context.appTextTheme.bodyLarge!
                .copyWith(color: Colors.grey.shade600),
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 35, maxWidth: 40),
          isDense: isDense,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
