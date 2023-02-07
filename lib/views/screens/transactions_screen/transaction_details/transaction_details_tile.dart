import 'package:flutter/material.dart';
import 'package:track_my_job/core/extensions/build_context_extension.dart';
import 'package:track_my_job/core/extensions/string_extension.dart';

import '../../../../core/constants/sizes.dart';
import '../../../shared/app_icon_button.dart';
import '../../../shared/app_text.dart';

class TransactionDetailTile extends StatelessWidget {
  const TransactionDetailTile({
    super.key,
    required this.iconBackgroundColor,
    required this.trailingText,
    required this.text1,
    required this.text2,
    required this.titleText,
    required this.leadingIcon,
    this.trailingText2,
    this.isThreeLine,
  });
  final Color iconBackgroundColor;
  final String trailingText;
  final String? trailingText2;
  final String text1;
  final String text2;
  final String titleText;
  final IconData leadingIcon;
  final bool? isThreeLine;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine ?? false,
      contentPadding: EdgeInsets.zero,
      leading: AppIconButton(
          icon: leadingIcon,
          onPressed: null,
          iconSize: 40,
          borderRadius: Sizes.p4,
          backgroundColor: iconBackgroundColor),
      title: AppText(
          text: titleText.capitalizeFirst,
          style: context.appTextTheme.bodyLarge!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: text1.capitalizeFirst,
            style: context.appTextTheme.bodyMedium!,
          ),
          AppText(
            text: text2.capitalizeFirst,
            style: context.appTextTheme.bodyMedium!,
          ),
        ],
      ),
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return trailingText2 == null
        ? SizedBox(
            height: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                    text: trailingText.capitalizeFirst,
                    style: context.appTextTheme.bodyMedium!),
              ],
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: trailingText.capitalizeFirst,
                    style: context.appTextTheme.bodyMedium!,
                  ),
                  AppText(
                    text: trailingText2!.capitalizeFirst,
                    style: context.appTextTheme.bodyMedium!,
                  ),
                ],
              ),
            ],
          );
  }
}
