import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get withShadow => this.copyWith(shadows: [
        BoxShadow(
          blurRadius: 5,
          offset: Offset(0, 0),
          color: Colors.white30,
          spreadRadius: 15,
        )
      ]);
}
