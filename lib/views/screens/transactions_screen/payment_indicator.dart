import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/widget_extension.dart';

class PaymentIndicator extends StatelessWidget {
  const PaymentIndicator(
      {super.key,
      required this.clientPayment,
      required this.providerPayment,
      required this.noterPayment,
      required this.refPayment,
      required this.height});
  final bool providerPayment;
  final bool clientPayment;
  final bool noterPayment;
  final bool refPayment;
  final double height;
  @override
  Widget build(BuildContext context) {
    // final color =
    //     paymentStatus ? Color.fromARGB(255, 82, 209, 87) : AppColors.secondary;
    // final glowColor = paymentStatus ? Colors.green : AppColors.secondary;
    return ColoredBox(
      color: _getColor(),
      child: SizedBox(
        width: 3,
        height: height,
      ).withShadow(color: _getColor()),
    );
  }

  Color _getColor() {
    if (clientPayment && providerPayment && noterPayment && refPayment) {
      return AppColors.green;
    } else if (!clientPayment ||
        (!clientPayment && !providerPayment && !noterPayment && !refPayment)) {
      return AppColors.secondary;
    } else
      return AppColors.amber;
  }
}
