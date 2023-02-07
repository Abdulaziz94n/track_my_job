import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/sizes.dart';
import '../../controllers/bottom_navigation_controller.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import 'app_text.dart';
import 'spacing_widgets.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          gradient: LinearGradient(
            colors: AppColors.bottomNavBarGradient,
          ),
        ),
        height: context.screenHeight * 0.09,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: BottomAppBarItem(
                  childNumber: 0,
                  onPressed: () {
                    controller.setIndex(0);
                  },
                  assetPath: AssetsManager.transactionIcon,
                  label: translations.transactions.tr.capitalizeFirst),
            ),
            Expanded(
              flex: 3,
              child: BottomAppBarItem(
                childNumber: 1,
                onPressed: () {
                  controller.setIndex(1);
                },
                assetPath: AssetsManager.partnersIcon,
                label: translations.partners.tr.capitalizeFirst,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: BottomAppBarItem(
                childNumber: 2,
                onPressed: () {
                  controller.setIndex(2);
                },
                assetPath: AssetsManager.noteIcon,
                label: translations.notes.tr.capitalizeFirst,
              ),
            ),
            Expanded(
              flex: 3,
              child: BottomAppBarItem(
                childNumber: 3,
                onPressed: () {
                  controller.setIndex(3);
                },
                assetPath: AssetsManager.summaryIcon,
                label: translations.summary.tr.capitalizeFirst,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem(
      {super.key,
      required this.childNumber,
      required this.onPressed,
      required this.assetPath,
      required this.label});
  final String assetPath;
  final int childNumber;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.find<BottomNavigationController>();
    final isSelected = bottomNavController.selectedIndex == childNumber;
    final selectedColor = Colors.white70;
    final unselectedColor = Colors.white;
    final iconSize = isSelected ? Sizes.p24 : Sizes.p16;
    final iconColor = isSelected ? selectedColor : unselectedColor;
    return InkWell(
      onTap: isSelected ? null : onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            color: iconColor,
            width: iconSize,
            height: iconSize,
          ),
          VerticalSpacingWidget(Sizes.p4),
          AppText(
            text: label,
            textAlign: TextAlign.center,
            style: context.appTextTheme.bodySmall!.copyWith(
              color: isSelected ? selectedColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
