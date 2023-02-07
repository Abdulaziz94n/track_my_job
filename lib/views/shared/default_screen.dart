import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Default Screen'),
      ),
      body: Center(
        child: Text(title ?? 'Default Screen'),
      ),
    );
  }
}
