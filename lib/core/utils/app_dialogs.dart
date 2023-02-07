import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_my_job/core/utils/utils.dart';

import '../../controllers/bottom_navigation_controller.dart';
import '../../views/screens/partners_screen/agencies_screen/add_agency_dialog.dart';
import '../../views/screens/partners_screen/noters_screen/add_noter_dialog.dart';
import '../../views/shared/app_loading_indicator.dart';
import '../../views/shared/app_warning_alert.dart';
import '../extensions/date_time_extension.dart';
import '../../views/screens/partners_screen/service_providers_screen/add_service_provider_dialog.dart';
import '../../views/shared/app_confirmation_dialog.dart';
import '../../views/shared/app_failure_dialog.dart';
import '../../views/shared/app_success_dialog.dart';
import '../../views/shared/app_year_picker.dart';

class AppDialogs {
  static final BottomNavigationController _navigationController = Get.find();

  static Future confirmDialog(
      {required BuildContext context,
      required String contentText,
      VoidCallback? onCancel,
      required VoidCallback onConfirm}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AppConfirmationAlert(
          contentText: contentText,
          onCancel: onCancel ?? () => Get.back(),
          onConfirm: onConfirm,
        );
      },
    );
  }

  static Future successDialog(
      {required BuildContext context,
      required String contentText,
      VoidCallback? onAction}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AppSuccessAlert(
          contentText: contentText,
          onAction: onAction,
        );
      },
    );
  }

  static Future warningDialog(
      {required BuildContext context, required String contentText}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AppWarningAlert(contentText: contentText);
      },
    );
  }

  static Future failureDialog(
      {required BuildContext context, required String contentText}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AppFailureAlert(contentText: contentText);
      },
    );
  }

  static Future showAndDismissAsyncDialog({
    required BuildContext context,
    required Future future,
    required bool confirmedDialg,
    required String errorMessage,
    required String successMessage,
    Widget Function(BuildContext context)? loadingIndicator,
  }) async {
    showDialog(
        context: context,
        builder: loadingIndicator ?? (context) => AppLoadingIndicator());
    try {
      await future;
      _navigationController.setFABfalse();
      Get.back();
      if (confirmedDialg) Get.back();
      Utils.showGetxSnackBar(contentText: successMessage);
    } catch (e) {
      Get.back();
      if (confirmedDialg) Get.back();
      Utils.showGetxErrorSnackBar(errorMessage: errorMessage);
    }
  }

  static Future<DateTime?> pickDateDialog(BuildContext context) async {
    DateTime now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, 1, 1, now.hour, now.minute)
          .subtract(Duration(days: 365)),
      lastDate: DateTime(now.year).monthEnd(12),
    );

    return selectedDate?.add(Duration(hours: now.hour, minutes: now.minute));
  }

  static Future<TimeOfDay?> pickTimeDialog(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 09, minute: 0);
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    return selectedTime;
  }

  static Future<DateTime?> pickDateTimeDialog(BuildContext context) async {
    final date = await pickDateDialog(context);
    if (date == null) return null;
    final time = await pickTimeDialog(context);
    if (time == null) return null;
    final selectedDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return selectedDateTime;
  }

  static showAddPartnerDialog(BuildContext context, int index) {
    switch (index) {
      case 0:
        showDialog(
          context: context,
          builder: (context) => AddAgencyDialog(),
        );
        break;
      case 1:
        showDialog(
          context: context,
          builder: (context) => AddServiceProviderDialog(),
        );
        break;
      case 2:
        showDialog(
          context: context,
          builder: (context) => AddNoterDialog(),
        );
        break;
      default:
        throw UnimplementedError();
    }
  }

  static Future<void> yearSelectorDialog(
      BuildContext context, Function(DateTime) onChanged) async {
    final now = DateTime.now();
    var selectedDate = DateTime(now.year);
    await showDialog(
        context: context,
        builder: (context) => AppYearPicker(
              selectedDate: selectedDate,
              onChanged: onChanged,
            ));
  }
}
