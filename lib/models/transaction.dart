import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../localization/translation_keys.dart' as translations;
import '../../core/constants/mongodb_keys_constants.dart';
import '../../core/enums/currencies.dart';
import '../../core/enums/transaction_types.dart';
import '../../core/extensions/list_extention.dart';
import '../core/extensions/string_extension.dart';
import 'extra_service.dart';
import 'noter_details.dart';
import 'reference_details.dart';

import '../../core/enums/customer_type.dart';
import '../../core/enums/payment_status.dart';

class Transaction {
  final String id;
  final TransactionType transactionType;
  final int amount;
  final Currency currency;
  final DateTime dateTime;
  final CustomerType customerType;
  final ReferenceDetails? referenceDetails;
  final String? customer;
  final PaymentStatus paymentStatus;
  final String? note;
  final int netProfit;
  final NoterDetails? noterDetails;
  final List<ExtraService>? extraServices;
  final bool isPinned;

  Transaction({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.currency,
    required this.dateTime,
    required this.customerType,
    required this.paymentStatus,
    required this.netProfit,
    required this.extraServices,
    required this.isPinned,
    this.referenceDetails,
    this.customer,
    this.note,
    this.noterDetails,
  });

  Map<String, dynamic> toMap() {
    log(dateTime.toString());
    return {
      MongoDbConstants.idKey: id,
      MongoDbConstants.transactinoTypeKey: transactionType.type,
      MongoDbConstants.amountKey: amount,
      MongoDbConstants.currencyKey: currency.name,
      MongoDbConstants.dateTimekey: dateTime, // DateTime.now().toUtc(),
      MongoDbConstants.customerTypeKey: customerType.name,
      MongoDbConstants.referenceDetailsKey:
          referenceDetails == ReferenceDetails()
              ? null
              : referenceDetails?.toMap(),
      MongoDbConstants.customerKey: customer,
      MongoDbConstants.paymentStatusKey: paymentStatus.description,
      MongoDbConstants.noteKey: note,
      MongoDbConstants.netProfitKey: netProfit,
      MongoDbConstants.noterDetailsKey: noterDetails?.toMap(),
      MongoDbConstants.extraServicesKey:
          (extraServices == null || extraServices!.isEmpty)
              ? null
              : extraServices?.map((x) => x.toMap()).toList(),
      MongoDbConstants.isPinnedKey: isPinned
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map[MongoDbConstants.idKey] ?? '',
        transactionType: TransactionType.fromString(
            map[MongoDbConstants.transactinoTypeKey]),
        amount: map[MongoDbConstants.amountKey]?.toInt() ?? 0,
        currency: Currency.fromString(map[MongoDbConstants.currencyKey]),
        dateTime: (map[MongoDbConstants.dateTimekey] as DateTime).toLocal(),
        customerType:
            CustomerType.fromString(map[MongoDbConstants.customerTypeKey]),
        referenceDetails: map[MongoDbConstants.referenceDetailsKey] == null
            ? null
            : ReferenceDetails.fromMap(
                map[MongoDbConstants.referenceDetailsKey]),
        customer: map[MongoDbConstants.customerKey],
        paymentStatus:
            PaymentStatus.fromString(map[MongoDbConstants.paymentStatusKey]),
        note: map[MongoDbConstants.noteKey],
        netProfit: map[MongoDbConstants.netProfitKey],
        noterDetails: map[MongoDbConstants.noterDetailsKey] == null
            ? null
            : NoterDetails.fromMap(
                map[MongoDbConstants.noterDetailsKey],
              ),
        extraServices: map['extra services'] != null
            ? (map['extra services'] as List<dynamic>).toExtraService()
            : null,
        isPinned: map[MongoDbConstants.isPinnedKey] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transaction(id: $id, transactionType: $transactionType, amount: $amount, currency: $currency, dateTime: $dateTime, customerType: $customerType, referenceDetails: $referenceDetails, customer: $customer, paymentStatus: $paymentStatus, note: $note, netProfit: $netProfit, noterDetails: $noterDetails, extraServices: $extraServices, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.transactionType == transactionType &&
        other.amount == amount &&
        other.currency == currency &&
        other.dateTime == dateTime &&
        other.customerType == customerType &&
        other.referenceDetails == referenceDetails &&
        other.customer == customer &&
        other.paymentStatus == paymentStatus &&
        other.note == note &&
        other.netProfit == netProfit &&
        other.noterDetails == noterDetails &&
        other.isPinned == isPinned &&
        listEquals(other.extraServices, extraServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        transactionType.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        dateTime.hashCode ^
        customerType.hashCode ^
        referenceDetails.hashCode ^
        customer.hashCode ^
        paymentStatus.hashCode ^
        note.hashCode ^
        netProfit.hashCode ^
        noterDetails.hashCode ^
        isPinned.hashCode ^
        extraServices.hashCode;
  }

  Transaction copyWith(
      {String? id,
      TransactionType? transactionType,
      int? amount,
      Currency? currency,
      DateTime? dateTime,
      CustomerType? customerType,
      ReferenceDetails? referenceDetails,
      String? customer,
      PaymentStatus? paymentStatus,
      String? note,
      int? netProfit,
      NoterDetails? noterDetails,
      List<ExtraService>? extraServices,
      bool? isPinned}) {
    return Transaction(
        id: id ?? this.id,
        transactionType: transactionType ?? this.transactionType,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        dateTime: dateTime ?? this.dateTime,
        customerType: customerType ?? this.customerType,
        referenceDetails: referenceDetails ?? this.referenceDetails,
        customer: customer ?? this.customer,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        note: note ?? this.note,
        netProfit: netProfit ?? this.netProfit,
        noterDetails: noterDetails ?? this.noterDetails,
        extraServices: extraServices ?? this.extraServices,
        isPinned: isPinned ?? this.isPinned);
  }

  static String getTransactionTypeTranslatedText(TransactionType type) {
    switch (type.type) {
      case 'translation':
        return translations.translation.tr.capitalizeFirst;
      case 'embassy':
        return translations.embassy.tr.capitalizeFirstOfEach;
      case 'visa':
        return translations.visa.tr.capitalizeFirstOfEach;
      case 'legal services':
        return translations.legal.tr.capitalizeFirstOfEach;
      case 'other':
        return translations.others.tr.capitalizeFirstOfEach;
      default:
        return translations.unknown.tr.capitalizeFirst;
    }
  }
}
