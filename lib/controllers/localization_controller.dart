import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/local_storage.dart';

class LocalizationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    prefLang = await LocalStorage.getLang();
    Get.updateLocale(Locale(prefLang ?? 'en'));
  }

  String? prefLang;

  void setLocale(Locale locale) {
    LocalStorage.setLang(locale.languageCode);
    Get.updateLocale(locale);
  }
}
