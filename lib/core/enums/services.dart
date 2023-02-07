import 'package:get/get.dart' hide GetStringUtils;
import '../../localization/translation_keys.dart' as translations;
import '../extensions/string_extension.dart';

enum Services {
  translation('translation'),
  appointments('embassy appointment'),
  docArrangement('arrange documents'),
  healthInsurance('health insurance'),
  docApproval('doc approval'),
  other('other');

  final String type;
  const Services(this.type);

  factory Services.fromString(String str) {
    switch (str) {
      case 'translation':
        return Services.translation;
      case 'embassy appointment':
        return Services.appointments;
      case 'arrange documents':
        return Services.docArrangement;
      case 'health insurance':
        return Services.healthInsurance;
      case 'doc approval':
        return Services.translation;
      default:
        return Services.other;
    }
  }

  static String getServiceTranslatedText(Services service) {
    switch (service.type) {
      case 'translation':
        return translations.translation.tr.capitalizeFirst;
      case 'embassy appointment':
        return translations.embassyAppointments.tr.capitalizeFirstOfEach;
      case 'arrange documents':
        return translations.arrangeDocs.tr.capitalizeFirstOfEach;
      case 'health insurance':
        return translations.healthInsurance.tr.capitalizeFirstOfEach;
      case 'doc approval':
        return translations.docApproval.tr.capitalizeFirstOfEach;
      case 'other':
        return translations.others.tr.capitalizeFirstOfEach;
      default:
        return translations.unknown.tr.capitalizeFirst;
    }
  }
}
