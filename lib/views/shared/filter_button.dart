import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import 'app_text.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
      required this.isFiltered,
      required this.isFilteredSize,
      required this.isNotFilteredSize,
      required this.scaleController,
      required this.onPressed});
  final bool isFiltered;
  final Size isFilteredSize;
  final Size isNotFilteredSize;
  final AnimationController scaleController;
  final VoidCallback onPressed;
  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isFiltered ? isFilteredSize.width : isNotFilteredSize.width,
      child: TextButton(
          style: TextButton.styleFrom(
              fixedSize: isFiltered ? Size(15, 15) : isNotFilteredSize,
              padding: EdgeInsets.symmetric(horizontal: Sizes.p4),
              shape: StadiumBorder()),
          onPressed: onPressed,
          child: ClipRect(
            child: Row(
              mainAxisSize: isFiltered ? MainAxisSize.min : MainAxisSize.max,
              children: [
                Flexible(
                    child: AnimatedRotation(
                  turns: !isFiltered ? 1 : -0.25,
                  duration: Duration(milliseconds: 300),
                  child: Image.asset(
                    'assets/icons/filter_icon.png',
                    width: 12,
                    height: 12,
                  ),
                )),
                AppText(
                  text: isFiltered
                      ? ''
                      : '  ' + translations.filter.tr.capitalizeFirst!,
                  style: context.appTextTheme.bodyMedium!,
                ),
              ],
            ),
          )),
    );
  }
}
