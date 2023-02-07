import 'package:get/get.dart';

import 'en_translations.dart';
import 'tr_translations.dart';

class AppContent extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': En().content,
      'tr': Tr().content,
    };
  }
}
