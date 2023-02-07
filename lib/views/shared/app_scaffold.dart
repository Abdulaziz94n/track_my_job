import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../../../core/constants/sizes.dart';
import '../../controllers/bottom_navigation_controller.dart';
import '../../controllers/localization_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import 'app_text.dart';
import 'appbar_logo.dart';
import 'spacing_widgets.dart';

class AppScaffold extends GetView<BottomNavigationController> {
  const AppScaffold({
    super.key,
    this.backgroundColor,
    this.globalKey,
    this.appBar,
    required this.title,
    this.resizeToAvoidBottomInset,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  })
  // : assert(appBar == null && text != null),
  //     assert(text == null && appBar != null)
  ;
  final PreferredSizeWidget? appBar;
  final Widget title;
  final GlobalKey? globalKey;
  final bool? resizeToAvoidBottomInset;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  LocalizationController get localizationController =>
      Get.find<LocalizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: backgroundColor,
      appBar: appBar ??
          AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
      body: Padding(
          padding: const EdgeInsets.only(
              top: Sizes.p32,
              left: Sizes.scaffoldBodyPadding + Sizes.p8,
              right: Sizes.scaffoldBodyPadding + Sizes.p8,
              bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLogo(),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            ThemeController.toggleTheme();
                          },
                          child: !Get.isDarkMode
                              ? Icon(
                                  Icons.dark_mode_outlined,
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius: 15,
                                        color: Colors.white,
                                        offset: Offset(0, 0))
                                  ],
                                )
                              : Icon(
                                  Icons.light_mode_outlined,
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius: 15,
                                        color: Colors.white,
                                        offset: Offset(0, 0))
                                  ],
                                )),
                      HorizontalSpacingWidget(Sizes.p8),
                      InkWell(
                          onTap: () {
                            final currentLang =
                                translations.lang.tr.toLowerCase();
                            final otherLang = currentLang == 'tr' ? 'en' : 'tr';
                            localizationController.setLocale(Locale(otherLang));
                          },
                          child: AppText(
                              style: context.appTextTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              text: 'lang'.tr.capitalizeFirst)),
                    ],
                  ),
                ],
              ).paddingOnly(left: Sizes.p8, right: Sizes.p8, bottom: Sizes.p16),
              title.paddingSymmetric(horizontal: Sizes.p8),
              Flexible(child: body!),
            ],
          )),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
