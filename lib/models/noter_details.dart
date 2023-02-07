import '../../core/enums/noter_payment.dart';

class NoterDetails {
  final String? id;
  final int? noterFee;
  final NoterPayment? noterPayment;
  final int? noterProfit;
  NoterDetails({this.id, this.noterFee, this.noterPayment, this.noterProfit});

  NoterDetails copyWith({
    String? id,
    int? noterFee,
    NoterPayment? noterPayment,
    int? noterProfit,
  }) {
    return NoterDetails(
        id: id ?? this.id,
        noterFee: noterFee ?? this.noterFee,
        noterPayment: noterPayment ?? this.noterPayment,
        noterProfit: noterProfit ?? this.noterProfit);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noterFee': noterFee,
      'noterPayment': noterPayment!.payment == 'done' ? true : false,
      'noter profit': noterProfit ?? 0
    };
  }

  factory NoterDetails.fromMap(Map<String, dynamic> map) {
    return NoterDetails(
      id: map['id'],
      noterFee: map['noterFee']?.toInt(),
      noterPayment: map['noterPayment'] != null
          ? NoterPayment.fromBool(map['noterPayment'])
          : null,
      noterProfit: map['noter profit'],
    );
  }

  @override
  String toString() {
    return 'NoterDetails(id: $id, noterFee: $noterFee, noterPayment: $noterPayment, noterProfit: $noterProfit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoterDetails &&
        other.id == id &&
        other.noterFee == noterFee &&
        other.noterPayment == noterPayment &&
        other.noterProfit == noterProfit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        noterFee.hashCode ^
        noterPayment.hashCode ^
        noterProfit.hashCode;
  }
}
