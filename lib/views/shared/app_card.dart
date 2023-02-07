import 'package:flutter/material.dart';
import '../../../core/constants/sizes.dart';

class AppCard extends StatelessWidget {
  const AppCard(
      {super.key,
      required this.child,
      this.clipBehavior,
      this.elevation,
      this.height,
      this.width,
      this.margin,
      this.backgroundImage,
      this.backgroundColor,
      this.padding});
  final Widget child;
  final Clip? clipBehavior;
  final double? elevation;
  final double? height;
  final double? width;
  final String? backgroundImage;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage('assets/images/$backgroundImage'),
                  fit: BoxFit.fill)
              : null),
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.p20)),
        margin: margin ?? const EdgeInsets.symmetric(vertical: Sizes.p4),
        color: backgroundImage != null ? Colors.transparent : backgroundColor,
        clipBehavior: clipBehavior,
        elevation: elevation,
        child: child,
      ),
    );
  }
}
