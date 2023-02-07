import 'package:get/get.dart' hide GetStringUtils;

import '../enums/note_priority.dart';
import '../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;

class AppConstTexts {
  List<String> appBarTitles = [
    translations.recentTransactinos.tr.capitalizeFirstOfEach,
    translations.partners.tr.capitalizeFirstOfEach,
    translations.notes.tr.capitalizeFirst,
    translations.summary.tr.capitalizeFirst
  ];

  static List<NotePriority> notePrioritiesList = [
    NotePriority.normal,
    NotePriority.important,
    NotePriority.veryImportant
  ];
}
