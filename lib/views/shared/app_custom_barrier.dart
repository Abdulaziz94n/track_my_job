import 'package:flutter/material.dart';

class CustomBarrier extends StatelessWidget {
  const CustomBarrier({super.key, required this.child, required this.active});
  final Widget child;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: active,
        child: child,
      ),
    );
  }
}
