import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:uuid/uuid.dart';
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../../../../localization/translation_keys.dart' as translations;

import '../../../../controllers/service_providers_controller.dart';
import '../../../../../core/enums/services.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/service_provider.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_text.dart';

import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_textfield.dart';

class AddServiceProviderDialog extends StatefulWidget {
  const AddServiceProviderDialog({super.key});

  @override
  State<AddServiceProviderDialog> createState() =>
      _AddServiceProviderDialogState();
}

class _AddServiceProviderDialogState extends State<AddServiceProviderDialog>
    with Validators {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<ServiceProviderController>();
  List<Widget> serviceSelector = [];
  Set<Services> services = {};
  String name = '';
  Uuid uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: AppText(
                text: translations.newServiceProvider.tr.capitalizeFirstOfEach,
                style: context.appTextTheme.titleLarge!,
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 3,
                      child: AppTextField.withOnChanged(
                          validator: validateIsEmpty,
                          onChanged: (val) => name = val!,
                          label: translations
                              .serviceProviderName.tr.capitalizeFirstOfEach),
                    ),
                    Flexible(
                        child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          serviceSelector.add(
                            AppDropDownField<Services>(
                              label: translations.service.tr.capitalizeFirst,
                              items:
                                  DropDownItems.servicesDropDownItems(context),
                              onSelect: (service) => services.add(service!),
                              validator: validateGenericIsEmpty,
                            ),
                          );
                        });
                      },
                    ))
                  ],
                ),
                ...serviceSelector,
              ]),
              actions: [
                AppOutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: translations.cancel.tr.capitalizeFirst),
                AppOutlinedButton(
                    onPressed: () async {
                      ServiceProvider serviceProvider = ServiceProvider(
                          id: uuid.v1(),
                          name: name.trimAndLower,
                          services: services.toList());
                      if (_formKey.currentState!.validate()) {
                        AppDialogs.showAndDismissAsyncDialog(
                          context: context,
                          future: _controller.addProvider(serviceProvider),
                          confirmedDialg: true,
                          errorMessage: translations
                              .errorAddServiceProvider.tr.capitalizeFirst,
                          successMessage: translations
                              .successAddServiceProvider.tr.capitalizeFirst,
                        );
                      }
                    },
                    text: translations.add.tr.capitalizeFirst),
              ],
            )),
      ),
    );
  }
}
