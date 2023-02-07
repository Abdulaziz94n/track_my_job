import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/extensions/string_extension.dart';
import '../../../core/utils/utils.dart';
import '../../localization/translation_keys.dart' as translations;

import 'app_elevated_btn.dart';

class MonthsPicker extends StatefulWidget {
  const MonthsPicker(
      {super.key,
      required this.onSelect,
      required this.text,
      this.padding,
      this.fixedSize});
  final ValueChanged<DateTime> onSelect;
  final String? text;
  final EdgeInsets? padding;
  final Size? fixedSize;
  @override
  State<MonthsPicker> createState() => _MonthsPickerState();
}

class _MonthsPickerState extends State<MonthsPicker> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
            fixedSize: widget.fixedSize,
            padding: EdgeInsets.zero,
            onPressed: () async {
              final pickedDate = await Utils.showMonthsYearPicker(context);
              if (pickedDate != null) {
                selectedDate = DateFormat('MM-yyyy').format(pickedDate);
                widget.onSelect(pickedDate);
              }
            },
            text: widget.text ?? translations.date.tr.capitalizeFirst)
        .paddingOnly(left: Sizes.p8);
  }
}
