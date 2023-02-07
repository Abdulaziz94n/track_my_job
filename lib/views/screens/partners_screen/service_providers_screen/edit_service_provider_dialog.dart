import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../localization/translation_keys.dart' as translations;
import '../../../../../core/constants/drop_downs_items.dart';
import '../../../../controllers/service_providers_controller.dart';
import '../../../../../core/enums/services.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../models/service_provider.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/utils/validator_mixin.dart';
import '../../../shared/app_dropdown.dart';
import '../../../shared/app_elevated_btn.dart';
import '../../../shared/app_outlined_btn.dart';
import '../../../shared/app_text.dart';
import '../../../shared/app_textfield.dart';
import '../../../shared/spacing_widgets.dart';

class EditServiceProviderDialog extends StatefulWidget {
  const EditServiceProviderDialog({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;

  @override
  State<EditServiceProviderDialog> createState() =>
      _EditServiceProviderDialogState();
}

class _EditServiceProviderDialogState extends State<EditServiceProviderDialog>
    with Validators {
  late TextEditingController _providerNameController;
  late List<Services> _editedServices;
  final _formKey = GlobalKey<FormState>();
  ServiceProviderController get serviceProvidercontroller => Get.find();

  @override
  void initState() {
    super.initState();
    _editedServices = [...widget.serviceProvider.services];
    _providerNameController =
        TextEditingController(text: widget.serviceProvider.name);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: AppText(
              text: translations.editServiceProvider.tr.capitalizeFirst,
              style: context.appTextTheme.bodyLarge!),
          content: Column(
            children: [
              AppTextField.withController(
                  validator: validateIsEmpty,
                  controller: _providerNameController,
                  label: translations
                      .serviceProviderName.tr.capitalizeFirstOfEach),
              for (int i = 0; i < _editedServices.length; i++)
                AppDropDownField<Services>(
                    initialValue: _editedServices[i],
                    label: translations.service.tr.capitalizeFirst,
                    items: DropDownItems.servicesDropDownItems(context),
                    onSelect: ((val) => _editedServices[i] = val!)),
              AppOutlinedButton(
                  onPressed: () => setState(() {
                        _editedServices.add(Services.translation);
                      }),
                  text: translations.addService.tr.capitalizeFirstOfEach),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppElevatedButton(
                      onPressed: () {
                        final ServiceProvider editedProvider = ServiceProvider(
                            id: widget.serviceProvider.id,
                            name: _providerNameController.text.trimAndLower,
                            services: _editedServices);
                        if (!serviceProvidercontroller.checkIfEdited(
                            widget.serviceProvider, editedProvider)) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          serviceProvidercontroller
                              .editServiceProvider(editedProvider);
                          Get.back();
                          Utils.showGetxSnackBar(
                              contentText: translations
                                  .successEditServiceProvider
                                  .tr
                                  .capitalizeFirstOfEach);
                        }
                      },
                      text: translations.save.tr.capitalizeFirst),
                  HorizontalSpacingWidget(Sizes.p12),
                  AppElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      text: translations.cancel.tr.capitalizeFirst)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
