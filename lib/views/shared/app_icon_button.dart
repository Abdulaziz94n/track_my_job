import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.disabledColor,
    this.iconSize,
    this.borderRadius,
  });
  final IconData icon;
  final Color? iconColor;
  final Color? disabledColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: ColoredBox(
        color: backgroundColor ?? Colors.transparent,
        child: IconButton(
          disabledColor: disabledColor,
          onPressed: onPressed,
          iconSize: iconSize,
          icon: Icon(
            icon,
            color: iconColor,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
