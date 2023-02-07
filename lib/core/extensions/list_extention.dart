import '../enums/payment_status.dart';
import '../enums/services.dart';
import '../../models/extra_service.dart';

extension DynamicListExtension on List<dynamic> {
  List<ExtraService> toExtraService() {
    final res = this
        .map((e) => ExtraService(
              serviceProviderName: e['serviceProviderName'],
              service: Services.fromString(e['service']),
              sellPrice: e['sellPrice'],
              buyPrice: e['buyPrice'],
              note: e['note'],
              paymentStatus: PaymentStatus.fromMap(e['paymentStatus']),
            ))
        .toList();
    return res;
  }
}
