import 'package:flutter/material.dart';

import 'app_error_widget.dart';
import 'app_loading_indicator.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  const AppFutureBuilder(
      {super.key, required this.future, required this.futureSuccessWidget});
  final Future<T> future;
  final Widget Function(T data) futureSuccessWidget;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return AppLoadingIndicator();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return AppErrorWidget();
              } else if (snapshot.hasData) {
                return FutureResultWidget<T>(
                    childBuilder: futureSuccessWidget,
                    resultData: snapshot.data!);
              } else {
                return AppErrorWidget();
              }
            default:
              return AppErrorWidget();
          }
        }));
  }
}

class FutureResultWidget<T> extends StatelessWidget {
  const FutureResultWidget(
      {super.key, required this.childBuilder, required this.resultData});
  final Widget Function(T data) childBuilder;
  final T resultData;
  @override
  Widget build(BuildContext context) {
    return childBuilder(resultData);
  }
}
