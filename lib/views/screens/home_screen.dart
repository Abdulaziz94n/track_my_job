import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import '../shared/app_custom_barrier.dart';
import 'tracking_screen/generate_excel_dialog.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/constants/sizes.dart';
import '../../controllers/bottom_navigation_controller.dart';
import '../../controllers/partners_controller.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../../../core/extensions/string_extension.dart';
import '../../localization/translation_keys.dart' as translations;
import '../../routing/app_router.dart';
import '../../services/mongo_db.dart';
import '../../../core/utils/app_dialogs.dart';
import '../shared/app_confirmation_dialog.dart';
import '../shared/app_custom_fab.dart';
import '../shared/app_loading_indicator.dart';
import '../shared/app_scaffold.dart';

import '../../../core/constants/constants_widgets.dart';
import '../shared/app_bottom_bar.dart';
import '../shared/screen_title_text.dart';
import 'notes_screen/add_note_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        if (details.primaryVelocity! > 0) {
          return await _onRefresh(context);
        }
      },
      child: GetBuilder<BottomNavigationController>(
          builder: (navigationController) {
        return AppScaffold(
          title: CustomBarrier(
            active: navigationController.fabExpanded,
            child: ScreenTitleText(
              text: AppConstTexts()
                  .appBarTitles[navigationController.selectedIndex],
              action: InkWell(
                onTap: () {
                  final PartnersController partnersController = Get.find();
                  _actionOnTap(context, navigationController.selectedIndex,
                      partnersController.index);
                },
                child: navigationController.selectedIndex == 3
                    ? Icon(Icons.summarize_outlined)
                    : Icon(
                        Icons.add,
                        size: Sizes.p24,
                      ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: WillPopScope(
              onWillPop: () async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AppConfirmationAlert(
                        contentText:
                            translations.sureToLeave.tr.capitalizeFirstOfEach,
                        onCancel: () {
                          Get.back(result: false);
                        },
                        onConfirm: () {
                          Get.back(canPop: true, result: true);
                        });
                  },
                );
              },
              child: _homePageBody(navigationController)),
          floatingActionButton: Visibility(
            visible: !isKeyboardOpen,
            child: Container(
                margin: EdgeInsets.only(bottom: context.screenHeight * 0.045),
                child: const AppCustomFAB()),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const AppBottomAppBar(),
        );
      }),
    );
  }

  Widget _homePageBody(BottomNavigationController navigationController) {
    return CustomBarrier(
        active: navigationController.fabExpanded,
        child:
            ConstantWidgets.screenBodies[navigationController.selectedIndex]);
  }

  Future _onRefresh(BuildContext context) async {
    if (MongoDbAPI.db != null && !MongoDbAPI.db!.isConnected) {
      showDialog(
          context: context, builder: ((context) => AppLoadingIndicator()));
      await MongoDbAPI.db!.open();
      Get.forceAppUpdate();
      Get.back();
    }
  }

  void _actionOnTap(BuildContext context, int index, int partnerIndex) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.addTransactionScreen);
        break;
      case 1:
        AppDialogs.showAddPartnerDialog(context, partnerIndex);
        break;
      case 2:
        showDialog(
          context: context,
          builder: (context) => AddNoteDialog(),
        );
        break;
      case 3:
        showDialog(
          context: context,
          builder: (context) => GenerateExcelDialog(),
        );
        break;
      default:
    }
  }
}
