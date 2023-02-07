import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import '../../../core/extensions/build_context_extension.dart';
import 'app_text.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, this.errorText});
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
          text: errorText ?? translations.somethingWentWrong.tr.capitalizeFirst,
          style: context.appTextTheme.titleSmall!),
    );
  }
}
