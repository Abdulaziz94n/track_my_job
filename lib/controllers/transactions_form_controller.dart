import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:track_my_job/core/utils/app_dialogs.dart';
import 'package:uuid/uuid.dart';
import '../core/enums/noter_payment.dart';
import '../core/enums/ref_payment_by.dart';
import '../core/enums/services.dart';
import '../core/extensions/string_extension.dart';
import '../localization/translation_keys.dart' as translations;
import '../core/enums/currencies.dart';
import '../core/enums/customer_type.dart';
import '../core/enums/payment_status.dart';
import '../core/enums/transaction_types.dart';
import '../models/agency.dart';
import '../models/extra_service.dart';
import '../models/noter_details.dart';
import '../models/reference_details.dart';
import '../models/transaction.dart';
import '../routing/app_router.dart';
import '../core/utils/utils.dart';
import 'transactions_controller.dart';

class TransactionsFormController extends GetxController {
  final transactionsController = Get.find<TransactionsController>();
  Transaction? editableTransaction;
  String? note;
  int? amount;
  int? netProfit;
  String? customer;
  CustomerType? customerType;
  Currency? currency;
  PaymentStatus? paymentStatus;
  TransactionType? transactionType;
  NoterDetails? noterDetails = NoterDetails();
  ReferenceDetails? referenceDetails = ReferenceDetails.initNull();
  List<ExtraService> extraServices = [];
  bool isPaymentByRef = false;
  DateTime? date;
  Uuid uuid = Uuid();
  bool fromUpdate = false;
  final formKey = GlobalKey<FormState>();

  //TODO: Fix edit refDetails when initNull() and refactor;

  void setAmount(int newAmount) {
    !fromUpdate
        ? amount = newAmount
        : editableTransaction =
            editableTransaction!.copyWith(amount: newAmount);
  }

  void setNetProfit(int newProfit) {
    !fromUpdate
        ? netProfit = newProfit
        : editableTransaction =
            editableTransaction!.copyWith(netProfit: newProfit);
  }

  void setCustomer(String newName) {
    !fromUpdate
        ? customer = newName
        : editableTransaction =
            editableTransaction!.copyWith(customer: newName);
  }

  void setNote(String newNote) {
    !fromUpdate
        ? note = newNote
        : editableTransaction = editableTransaction!.copyWith(note: newNote);
  }

  void setCustomerType(CustomerType type) {
    !fromUpdate
        ? customerType = type
        : editableTransaction =
            editableTransaction!.copyWith(customerType: type);
  }

  void setCurrency(Currency curr) {
    !fromUpdate
        ? currency = curr
        : editableTransaction = editableTransaction!.copyWith(currency: curr);
  }

  void setPaymentStatus(PaymentStatus status) {
    !fromUpdate
        ? paymentStatus = status
        : editableTransaction =
            editableTransaction!.copyWith(paymentStatus: status);
  }

  void setTransactionType(TransactionType type) {
    !fromUpdate
        ? transactionType = type
        : editableTransaction =
            editableTransaction!.copyWith(transactionType: type);
  }

  void setNoterPayment(NoterPayment payment) {
    !fromUpdate
        ? noterDetails = noterDetails!.copyWith(noterPayment: payment)
        : editableTransaction = editableTransaction!.copyWith(
            noterDetails: editableTransaction!.noterDetails
                    ?.copyWith(noterPayment: payment) ??
                NoterDetails(noterPayment: payment));
  }

  void setNoterFee(int fee) {
    !fromUpdate
        ? noterDetails = noterDetails!.copyWith(noterFee: fee)
        : editableTransaction = editableTransaction!.copyWith(
            noterDetails:
                editableTransaction!.noterDetails?.copyWith(noterFee: fee) ??
                    NoterDetails(noterFee: fee));
  }

  void setNoterProfit(int profit) {
    !fromUpdate
        ? noterDetails = noterDetails!.copyWith(noterProfit: profit)
        : editableTransaction = editableTransaction!.copyWith(
            noterDetails: editableTransaction!.noterDetails
                    ?.copyWith(noterProfit: profit) ??
                NoterDetails(noterProfit: profit));
  }

  void setNoterNo(String id) {
    !fromUpdate
        ? noterDetails = noterDetails!.copyWith(id: id)
        : editableTransaction = editableTransaction!.copyWith(
            noterDetails: editableTransaction!.noterDetails?.copyWith(id: id) ??
                NoterDetails(id: id));
  }

  void setDate(DateTime? newDate) {
    !fromUpdate
        ? date = newDate
        : editableTransaction = editableTransaction!
            .copyWith(dateTime: newDate ?? editableTransaction!.dateTime);
  }

  List<ExtraService> getExtraServices() {
    List<ExtraService>? res;
    if (fromUpdate) {
      res = editableTransaction!.extraServices ?? [];
    } else {
      res = extraServices;
    }
    return res;
  }

  void setRef(Agency agency) {
    !fromUpdate
        ? referenceDetails = referenceDetails!.copyWith(reference: agency)
        : editableTransaction = editableTransaction!.copyWith(
            referenceDetails: editableTransaction!.referenceDetails!
                .copyWith(reference: agency));
  }

  void setRefPortion(String refPortion) {
    !fromUpdate
        ? referenceDetails =
            referenceDetails!.copyWith(referencePortion: refPortion)
        : editableTransaction = editableTransaction!.copyWith(
            referenceDetails: editableTransaction!.referenceDetails!
                .copyWith(referencePortion: refPortion));
  }

  void setRefPayment(PaymentStatus paymentStatus) {
    !fromUpdate
        ? referenceDetails =
            referenceDetails!.copyWith(toRefPayment: paymentStatus)
        : editableTransaction = editableTransaction!.copyWith(
            referenceDetails: editableTransaction!.referenceDetails!
                .copyWith(toRefPayment: paymentStatus));
  }

  void setPaymentBy(PaymentBy paymentBy) {
    if (!fromUpdate) {
      if (paymentBy == PaymentBy.reference) {
        isPaymentByRef = true;
        referenceDetails = referenceDetails!.copyWith(
            referencePortion: '0',
            paymentBy: paymentBy,
            toRefPayment: PaymentStatus.paid);
        update(['transaction form']);
      } else {
        isPaymentByRef = false;
        referenceDetails = referenceDetails!.copyWith(paymentBy: paymentBy);
        update(['transaction form']);
      }
    } else {
      if (paymentBy == PaymentBy.reference) {
        isPaymentByRef = true;
        editableTransaction = editableTransaction!.copyWith(
          referenceDetails: editableTransaction!.referenceDetails!.copyWith(
              referencePortion: '0',
              paymentBy: paymentBy,
              toRefPayment: PaymentStatus.paid),
        );
        update(['transaction form']);
      } else {
        isPaymentByRef = false;
        editableTransaction = editableTransaction!.copyWith(
            referenceDetails: editableTransaction!.referenceDetails!
                .copyWith(paymentBy: paymentBy));
        update(['transaction form']);
      }
    }
  }

  void setRefNote(String refNote) {
    !fromUpdate
        ? referenceDetails = referenceDetails!.copyWith(note: refNote)
        : editableTransaction = editableTransaction!.copyWith(
            referenceDetails:
                editableTransaction!.referenceDetails!.copyWith(note: refNote));
  }

  void setExtraServices(List<ExtraService> services) {
    !fromUpdate
        ? extraServices = services
        : editableTransaction =
            editableTransaction!.copyWith(extraServices: services);
  }

  void setExtraServiceProvider(int index, String name) {
    !fromUpdate
        ? extraServices[index] =
            extraServices[index].copyWith(serviceProviderName: name)
        : editableTransaction!.extraServices![index] = editableTransaction!
            .extraServices![index]
            .copyWith(serviceProviderName: name);
  }

  void setExtraServiceService(int index, Services service) {
    !fromUpdate
        ? extraServices[index] = extraServices[index].copyWith(service: service)
        : editableTransaction!.extraServices![index] = editableTransaction!
            .extraServices![index]
            .copyWith(service: service);
  }

  void setExtraServiceBuyPrice(int index, String buyPrice) {
    !fromUpdate
        ? extraServices[index] =
            extraServices[index].copyWith(buyPrice: buyPrice)
        : editableTransaction!.extraServices![index] = editableTransaction!
            .extraServices![index]
            .copyWith(buyPrice: buyPrice);
  }

  void setExtraServiceSellPrice(int index, String sellPrice) {
    !fromUpdate
        ? extraServices[index] =
            extraServices[index].copyWith(sellPrice: sellPrice)
        : editableTransaction!.extraServices![index] = editableTransaction!
            .extraServices![index]
            .copyWith(sellPrice: sellPrice);
  }

  void setExtraServicePayment(int index, PaymentStatus paymentStatus) {
    !fromUpdate
        ? extraServices[index] =
            extraServices[index].copyWith(paymentStatus: paymentStatus)
        : editableTransaction!.extraServices![index] = editableTransaction!
            .extraServices![index]
            .copyWith(paymentStatus: paymentStatus);
  }

  void setExtraServiceNote(int index, String? note) {
    !fromUpdate
        ? extraServices[index] = extraServices[index].copyWith(note: note)
        : editableTransaction!.extraServices![index] =
            editableTransaction!.extraServices![index].copyWith(note: note);
  }

  void addExtraService() {
    !fromUpdate
        ? extraServices.add(ExtraService())
        : editableTransaction!.extraServices?.add(ExtraService());
    update(['transaction form']);
  }

  void deleteExtraService(int index) {
    extraServices.removeAt(index);
    update(['transaction form']);
  }

  void clearExtraServices() {
    !fromUpdate
        ? extraServices.clear()
        : editableTransaction!.extraServices!.clear();
    update(['transaction form']);
  }

  void setFromUpdate() {
    fromUpdate = true;
    if (editableTransaction!.extraServices == null) {
      editableTransaction = editableTransaction!.copyWith(extraServices: []);
    }
    if (editableTransaction!.referenceDetails == null) {
      editableTransaction = editableTransaction!
          .copyWith(referenceDetails: ReferenceDetails.initNull());
    }
    update(['transaction form']);
  }

  Transaction addedTransaction() {
    Transaction newTransaction = Transaction(
        id: uuid.v1(),
        transactionType: transactionType!,
        amount: amount!,
        currency: currency!,
        dateTime: date ?? DateTime.now(),
        noterDetails: noterDetails == NoterDetails() ? null : noterDetails,
        referenceDetails: referenceDetails == ReferenceDetails.initNull()
            ? null
            : referenceDetails,
        customer: customer!.trimAndLower,
        note: note?.trimAndLower,
        customerType: customerType!,
        paymentStatus: paymentStatus!,
        netProfit: netProfit!,
        extraServices: extraServices.isEmpty ? null : extraServices,
        isPinned: false);
    return newTransaction;
  }

  Future<void> submitForm(
      BuildContext context, Transaction? oldTransaction) async {
    if (fromUpdate) {
      if (oldTransaction!.extraServices == null) {
        oldTransaction = oldTransaction.copyWith(extraServices: []);
      }
      // if (oldTransaction.referenceDetails == null) {
      //   oldTransaction =
      //       oldTransaction.copyWith(referenceDetails: ReferenceDetails());
      // }
    }
    !fromUpdate
        ? addTransaction(context)
        : editTransaction(context, oldTransaction!);
  }

  void addTransaction(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await transactionsController.addTransaction(addedTransaction());
        AppDialogs.successDialog(
          context: context,
          contentText:
              translations.successAddTransaction.tr.capitalizeFirstOfEach,
          onAction: _confirmAddTransaction,
        );
      } catch (e) {
        Utils.showGetxErrorSnackBar(
            errorMessage: translations.errorAddTransaction.tr.capitalizeFirst);
      }
    } else {
      Utils.showGetxErrorSnackBar(
          errorTitle: translations.invalidForm.tr.capitalizeFirstOfEach,
          errorMessage:
              translations.pleaseCheckRequiredFields.tr.capitalizeFirst);
    }
  }

  void editTransaction(BuildContext context, Transaction oldTransaction) async {
    if (formKey.currentState!.validate()) {
      if (oldTransaction == editableTransaction) {
        AppDialogs.warningDialog(
            context: context,
            contentText: translations.noChangesMade.tr.capitalizeFirstOfEach);
        return;
      }
      try {
        await transactionsController.editTransaction(editableTransaction!);
        AppDialogs.successDialog(
            context: context,
            contentText:
                translations.successEditTransaction.tr.capitalizeFirstOfEach,
            onAction: _confirmEditTransaction);
      } catch (e) {
        Utils.showGetxErrorSnackBar(
            errorMessage: translations.errorEditTransaction.tr.capitalizeFirst);
      }
    } else {
      Utils.showGetxErrorSnackBar(
          errorTitle: translations.invalidForm.tr.capitalizeFirstOfEach,
          errorMessage:
              translations.pleaseCheckRequiredFields.tr.capitalizeFirst);
    }
  }

  void _confirmEditTransaction() {
    Get.back();
    Get.back();
    Get.delete<TransactionsFormController>();
  }

  void _confirmAddTransaction() {
    Get.offNamedUntil(AppRoutes.homeScreen, (route) => false);
    Get.delete<TransactionsFormController>();
  }
}
