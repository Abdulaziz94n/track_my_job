import 'package:flutter/material.dart';
import 'app_texts.dart';
import 'dummy_data.dart';
import '../enums/noter_payment.dart';
import '../enums/ref_payment_by.dart';
import '../enums/services.dart';
import '../enums/transaction_types.dart';
import '../extensions/string_extension.dart';
import '../extensions/build_context_extension.dart';
import '../../models/agency.dart';
import '../../models/noter.dart';
import '../../views/shared/app_text.dart';
import '../enums/currencies.dart';
import '../enums/customer_type.dart';
import '../enums/note_priority.dart';
import '../enums/payment_status.dart';

class DropDownItems {
  static List<String> _months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  static List<DropdownMenuItem<CustomerType>> customerTypeDropDownItems(
          BuildContext context) =>
      CustomerType.values
          .map((e) => DropdownMenuItem<CustomerType>(
              value: e,
              child: AppText(
                text: e.name.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();
  static List<DropdownMenuItem<PaymentStatus>> paymentDropDownItems(
          BuildContext context) =>
      PaymentStatus.values
          .map((e) => DropdownMenuItem<PaymentStatus>(
              value: e,
              child: AppText(
                text: e.description.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<Currency>> currenciesDropDownItems(
          BuildContext context) =>
      Currency.values
          .map((e) => DropdownMenuItem<Currency>(
              value: e,
              child: AppText(
                text: e.name.toString().toUpperCase(),
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<TransactionType>> transactionTypesDropDownItems(
          BuildContext context) =>
      TransactionType.values
          .map((e) => DropdownMenuItem<TransactionType>(
              value: e,
              child: AppText(
                text: e.type.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<NoterPayment>> noterPaymentDropDownItems(
          BuildContext context) =>
      NoterPayment.values
          .map((e) => DropdownMenuItem<NoterPayment>(
              value: e,
              child: AppText(
                text: e.payment.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<Noter>> noterListDropDownItems(
          BuildContext context) =>
      DummyData.notersList
          .map((e) => DropdownMenuItem<Noter>(
              value: e,
              child: AppText(
                text: e.id.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<Agency>> agenciesListDropDownItems(
          BuildContext context) =>
      DummyData.agenciesList
          .map((e) => DropdownMenuItem<Agency>(
              value: e,
              child: AppText(
                text: e.name.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<PaymentBy>> paymentByDropDownItems(
          BuildContext context) =>
      PaymentBy.values
          .map((e) => DropdownMenuItem<PaymentBy>(
              value: e,
              child: AppText(
                text: e.name.toString().capitalizeFirst,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<Services>> servicesDropDownItems(
          BuildContext context) =>
      Services.values
          .map((e) => DropdownMenuItem<Services>(
              value: e,
              child: FittedBox(
                child: AppText(
                  text: e.type.toString().capitalizeFirst,
                  style: context.appTextTheme.bodyMedium!,
                ),
              )))
          .toList();

  static List<DropdownMenuItem<String>> serviceProvidersNamesDropDownItems(
          BuildContext context) =>
      DummyData.serviceProvidersList
          .map((e) => DropdownMenuItem<String>(
              value: e.name,
              child: AppText(
                text: e.name,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();
  static List<DropdownMenuItem<NotePriority>> notePriorityDropDownItems(
          BuildContext context) =>
      AppConstTexts.notePrioritiesList
          .map((e) => DropdownMenuItem<NotePriority>(
              value: e,
              child: AppText(
                text: e.type.capitalizeFirstOfEach,
                style: context.appTextTheme.bodyMedium!,
              )))
          .toList();

  static List<DropdownMenuItem<String>> months(BuildContext context) => _months
      .map((month) => DropdownMenuItem<String>(
          value: month,
          child: AppText(
            text: month,
            style: context.appTextTheme.bodyMedium!,
          )))
      .toList();
}
