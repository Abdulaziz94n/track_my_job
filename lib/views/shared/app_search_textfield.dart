import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../core/constants/sizes.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;

import 'app_textfield.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    return AppTextField.withOnChanged(
      onChanged: onChanged,
      label: translations.search.tr.capitalizeFirst,
      prefixIcon: const Icon(Icons.search),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
          vertical: Sizes.p12, horizontal: Sizes.p12),
      fontSize: Sizes.p14,
    );
  }
}
