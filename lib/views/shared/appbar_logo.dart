import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Transform.translate(
            offset: Offset(-7, -7),
            child: Image(
              image: AssetImage(AssetsManager.appbarLogo),
              width: 40,
              height: 40,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Image(
            image: AssetImage(AssetsManager.appbarLogo),
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}
