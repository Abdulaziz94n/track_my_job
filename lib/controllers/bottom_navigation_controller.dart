import 'package:get/get.dart';
import 'agencies_controller.dart';
import 'transactions_controller.dart';

class BottomNavigationController extends GetxController {
  int _selectedIndex = 0;

  TransactionsController get transController =>
      Get.find<TransactionsController>();

  AgenciesController get agenciesController => Get.find<AgenciesController>();

  int get selectedIndex => _selectedIndex;

  bool _fabStatus = false;

  bool get fabExpanded => _fabStatus;

  void setFABfalse() {
    _fabStatus = false;
    update();
  }

  void setFABtrue() {
    _fabStatus = true;
    update();
  }

  void setIndex(int index) {
    _selectedIndex = index;
    transController.resetFilters();
    agenciesController.resetQuery();
    update();
  }
}
