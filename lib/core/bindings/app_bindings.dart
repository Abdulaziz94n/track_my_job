import 'package:get/get.dart';
import '../../controllers/agencies_controller.dart';
import '../../controllers/bottom_navigation_controller.dart';
import '../../controllers/connectivity_controller.dart';
import '../../controllers/localization_controller.dart';
import '../../controllers/noters_controller.dart';
import '../../controllers/notes_controller.dart';
import '../../controllers/partners_controller.dart';
import '../../controllers/service_providers_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/transactions_controller.dart';
import '../../services/mongo_db.dart';
import '../repositories/fake_repositories/fake_agency_repository.dart';
import '../repositories/fake_repositories/fake_noter_repo.dart';
import '../repositories/fake_repositories/fake_notes_repo.dart';
import '../repositories/fake_repositories/fake_service_provider_repo.dart';
import '../repositories/fake_repositories/fake_transactions_repo.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MongoDbAPI());
    Get.put(NotersController(FakeNoterRepository()));
    Get.put(BottomNavigationController());
    Get.put(TransactionsController(FakeTransactionsRepository()));
    Get.put(ServiceProviderController(FakeServiceProviderRepository()));
    Get.put(AgenciesController(FakeAgencyRepository()));
    Get.put(LocalizationController());
    Get.put(PartnersController());
    Get.put(NotesController(FakeNotesRepository()));
    Get.put(ThemeController());
    Get.put(ConnectivityController());
  }
}
