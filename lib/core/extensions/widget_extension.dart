import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget coloredPadded({Color? color, double? paddingVal}) => ColoredBox(
        color: color ?? Colors.yellow,
        child: Padding(
          padding: EdgeInsets.all(paddingVal ?? 4),
          child: this,
        ),
      );

  Widget paddedColored({Color? color, double? paddingVal}) => Padding(
        padding: EdgeInsets.all(paddingVal ?? 4),
        child: ColoredBox(
          color: color ?? Colors.red,
          child: this,
        ),
      );

  Widget colored({Color? color}) => ColoredBox(
        color: color ?? Colors.red,
        child: this,
      );

  Widget align({Alignment? alignment}) =>
      Align(alignment: alignment ?? Alignment.centerLeft, child: this);

  Widget get center => Center(child: this);

  Widget withShadow(
          {Offset offset = const Offset(0, 0),
          double blurRadius = 3,
          Color color = Colors.white}) =>
      DecoratedBox(
        decoration: BoxDecoration(color: color, boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            offset: offset,
            color: color,
          )
        ]),
        child: this,
      );
}
