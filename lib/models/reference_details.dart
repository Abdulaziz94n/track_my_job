import 'dart:convert';

import '../../core/enums/payment_status.dart';
import '../../core/enums/ref_payment_by.dart';
import 'agency.dart';

class ReferenceDetails {
  final Agency? reference;
  final String? note;
  final PaymentBy? paymentBy;
  final String? referencePortion;
  final PaymentStatus? toRefPayment;
  ReferenceDetails({
    this.reference,
    this.note,
    this.paymentBy,
    this.referencePortion,
    this.toRefPayment,
  });

  ReferenceDetails.initNull(
      {this.reference,
      this.paymentBy,
      this.referencePortion,
      this.toRefPayment,
      this.note});

  ReferenceDetails copyWith({
    Agency? reference,
    String? note,
    PaymentBy? paymentBy,
    String? referencePortion,
    PaymentStatus? toRefPayment,
  }) {
    return ReferenceDetails(
      reference: reference ?? this.reference,
      note: note ?? this.note,
      paymentBy: paymentBy ?? this.paymentBy,
      referencePortion: referencePortion ?? this.referencePortion,
      toRefPayment: toRefPayment ?? this.toRefPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference?.toMap(),
      'note': note,
      'paymentBy': paymentBy?.name,
      'referencePortion': referencePortion,
      'toRefPayment': toRefPayment?.description,
    };
  }

  factory ReferenceDetails.fromMap(Map<String, dynamic> map) {
    return ReferenceDetails(
      reference: Agency.fromMap(map['reference']),
      note: map['note'],
      paymentBy: PaymentBy.fromString(map['paymentBy']),
      referencePortion: map['referencePortion'],
      toRefPayment: PaymentStatus.fromString(map['toRefPayment']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceDetails.fromJson(String source) =>
      ReferenceDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReferenceDetails(reference: $reference, note: $note, paymentBy: $paymentBy, referencePortion: $referencePortion, toRefPayment: $toRefPayment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReferenceDetails &&
        other.reference == reference &&
        other.note == note &&
        other.paymentBy == paymentBy &&
        other.referencePortion == referencePortion &&
        other.toRefPayment == toRefPayment;
  }

  @override
  int get hashCode {
    return reference.hashCode ^
        note.hashCode ^
        paymentBy.hashCode ^
        referencePortion.hashCode ^
        toRefPayment.hashCode;
  }
}
