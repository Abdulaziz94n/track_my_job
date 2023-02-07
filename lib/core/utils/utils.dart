import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../localization/translation_keys.dart' as translations;
import '../../views/shared/app_text.dart';
import '../constants/app_keys.dart';
import '../../views/shared/app_confirmation_dialog.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/string_extension.dart';

class Utils {
  static showMaterialSnackBar(
      {required String contentText, Duration? duration}) {
    final scaffoldMessengerState = kGlobaMessengerKey.currentState;
    scaffoldMessengerState!
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(contentText),
        duration: duration ?? const Duration(seconds: 1),
      ));
  }

  static showGetxTestSnackBar() {
    Get.showSnackbar(const GetSnackBar(
      title: 'Text Snack Bar',
      message: 'message',
      duration: Duration(seconds: 1),
    ));
  }

  static showConnectionBanner(
      {required String message, required Color backgroundColor}) {
    showSimpleNotification(
      Builder(
        builder: (context) => AppText(
          style: context.appTextTheme.bodyLarge!,
          text: translations.connectionStateUpdate.tr.capitalizeFirst,
        ),
      ),
      subtitle: Builder(
        builder: (context) =>
            AppText(style: context.appTextTheme.bodyMedium!, text: message),
      ),
      background: backgroundColor,
    );
  }

  static showGetxSnackBar({String? title, required String contentText}) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: contentText,
      duration: Duration(seconds: 1),
    ));
  }

  static showGetxErrorSnackBar({String? errorMessage, String? errorTitle}) {
    Get.showSnackbar(GetSnackBar(
      title: errorTitle ?? 'Error Snack Bar',
      message: errorMessage ?? 'Error message',
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 1),
    ));
  }

  static Future<DateTime?> showMonthsYearPicker(BuildContext context) async {
    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 1).subtract(Duration(days: 365)),
      lastDate: DateTime(DateTime.now().year, 12),
    );
    return selectedDate;
  }

  static List<String> getCurrentWeekDays() {
    final List<String> currentWeekDays = [];
    final now = DateTime.now();
    final currentDay = now.weekday;
    for (int i = currentDay; i >= 1; i--) {
      final preDayDate = now.subtract(Duration(days: i - 1));
      final preDay = DateFormat('yyyy-MM-dd').format(preDayDate);
      currentWeekDays.add(preDay);
    }
    for (int i = currentDay + 1; i <= 7; i++) {
      final nextDayDate = now.add(Duration(days: i - currentDay));
      final nextDay = DateFormat('yyyy-MM-dd').format(nextDayDate);
      currentWeekDays.add(nextDay);
    }
    return currentWeekDays;
  }

  static Future<bool> willPopConfirmation(
      {required BuildContext context, required String contentText}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AppConfirmationAlert(
            contentText: contentText,
            onCancel: () {
              Get.back(result: false);
            },
            onConfirm: () {
              Get.back(canPop: true, result: true);
              Get.back(canPop: true, result: true);
            });
      },
    );
  }

  static invalidateController<T extends GetxController>(
      {bool? permanent, required T controller}) {
    Get.delete<T>(force: true);
    Get.put(controller, permanent: permanent ?? false);
  }
}
