import 'package:flutter/material.dart';
import '../../../core/extensions/string_extension.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text.hardCoded),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )),
        ],
      );
    });
  }
}
