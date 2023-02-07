import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  Size get screenSize => MediaQuery.of(this).size;
  TextTheme get appTextTheme => Theme.of(this).textTheme;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get onBackground => Theme.of(this).colorScheme.onBackground;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;
  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  bool get isMobile => MediaQuery.of(this).size.width <= 800;
  // getter for orientations can be added
}
