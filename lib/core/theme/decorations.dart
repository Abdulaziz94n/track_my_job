import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_my_job/core/extensions/build_context_extension.dart';

import '../constants/app_colors.dart';

class WidgetsDecoration {
  static InputDecoration textFieldDecoration(BuildContext context) =>
      InputDecoration(
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.secondary)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Get.isDarkMode ? AppColors.lightGrey : Colors.black12),
          borderRadius: BorderRadius.circular(20),
        ),
      );

  static InputDecoration dropDownTextFieldDecoration(BuildContext context) =>
      InputDecoration(
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: context.primaryColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      );
}
