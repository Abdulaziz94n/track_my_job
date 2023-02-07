import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed ?? () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Icon(Icons.arrow_back),
          ),
        ));
  }
}
