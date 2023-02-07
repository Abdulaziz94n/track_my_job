import 'package:get/get.dart';

class PartnersController extends GetxController {
  int _selectedPartnerIndex = 0;

  void setIndex(int newIndex) {
    _selectedPartnerIndex = newIndex;
    update();
  }

  int get index => _selectedPartnerIndex;
}
