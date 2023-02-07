import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.style,
    required this.text,
    this.textAlign,
    this.overflow,
    this.padding,
    this.maxLines,
  });
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  final int? maxLines;
  final String text;
  final TextOverflow? overflow;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: style,
      ),
    );
  }
}
