import 'dart:convert';

import '../../core/enums/payment_status.dart';
import '../../core/enums/services.dart';

class ExtraService {
  final String? serviceProviderName;
  final Services? service;
  final String? buyPrice;
  final String? sellPrice;
  final String? note;
  final PaymentStatus? paymentStatus;
  ExtraService(
      {this.serviceProviderName,
      this.service,
      this.buyPrice,
      this.sellPrice,
      this.note,
      this.paymentStatus});

  ExtraService copyWith({
    String? serviceProviderName,
    Services? service,
    String? buyPrice,
    String? sellPrice,
    String? note,
    PaymentStatus? paymentStatus,
  }) {
    return ExtraService(
      serviceProviderName: serviceProviderName ?? this.serviceProviderName,
      service: service ?? this.service,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      note: note ?? this.note,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceProviderName': serviceProviderName,
      'service': service?.type,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'paymentStatus': paymentStatus?.toMap(),
      'note': note,
    };
  }

  factory ExtraService.fromMap(Map<String, dynamic> map) {
    return ExtraService(
        serviceProviderName: map['serviceProviderName'],
        service: Services.fromString(map['service']),
        buyPrice: map['buyPrice'],
        sellPrice: map['sellPrice'],
        note: map['note'],
        paymentStatus: PaymentStatus.fromMap(map['paymentStatus']));
  }

  String toJson() => json.encode(toMap());

  factory ExtraService.fromJson(String source) =>
      ExtraService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExtraService(serviceProviderName: $serviceProviderName, service: $service, buyPrice: $buyPrice, sellPrice: $sellPrice, note: $note, paymentStatus: $paymentStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExtraService &&
        other.serviceProviderName == serviceProviderName &&
        other.service == service &&
        other.buyPrice == buyPrice &&
        other.sellPrice == sellPrice &&
        other.note == note &&
        other.paymentStatus == paymentStatus;
  }

  @override
  int get hashCode {
    return serviceProviderName.hashCode ^
        service.hashCode ^
        buyPrice.hashCode ^
        sellPrice.hashCode ^
        note.hashCode ^
        paymentStatus.hashCode;
  }
}
