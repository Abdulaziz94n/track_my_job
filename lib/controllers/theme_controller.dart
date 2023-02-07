import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/local_storage.dart';
import '../core/theme/custom_theme.dart';

class ThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    prefTheme = await LocalStorage.getTheme();
  }

  static String? prefTheme;

  static void toggleTheme() {
    if (Get.isDarkMode) {
      LocalStorage.setTheme(ThemeModes.light);
      Get.changeTheme(CustomTheme.lightTheme);
    } else {
      LocalStorage.setTheme(ThemeModes.dark);
      Get.changeTheme(CustomTheme.darkTheme);
    }
  }

  static ThemeData getTheme() {
    if (prefTheme == null || prefTheme == ThemeModes.dark.name) {
      return CustomTheme.darkTheme;
    } else {
      return CustomTheme.lightTheme;
    }
  }
}

enum ThemeModes {
  light,
  dark;
}
