import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;

import '../../../localization/translation_keys.dart' as translations;
import '../core/constants/app_colors.dart';
import '../core/extensions/string_extension.dart';
import '../core/utils/utils.dart';

class ConnectivityController extends GetxService {
  ConnectivityController();
  late StreamSubscription _connectionListener;

  @override
  void onInit() {
    super.onInit();
    _startListenToConnection();
  }

  void _startListenToConnection() {
    _connectionListener =
        Connectivity().onConnectivityChanged.listen(_listenToConnection);
  }

  void _stopListenToConnection() {
    _connectionListener.cancel();
  }

  void listenAndAct(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        return;
      case AppLifecycleState.detached:
        return;
      case AppLifecycleState.resumed:
        _startListenToConnection();
        return;
      case AppLifecycleState.paused:
        _stopListenToConnection();
        return;
      default:
        assert(false, "Invalid AppLifecycleState value: $state");
    }
  }

  _listenToConnection(ConnectivityResult result) {
    final hasConnection = result != ConnectivityResult.none;
    final color = hasConnection ? AppColors.green : AppColors.secondary;
    final message = hasConnection
        ? '${translations.connectionStatus.tr.capitalizeFirst} ${result.name.capitalizeFirst}'
        : translations.noConnection.tr.capitalizeFirst;
    Utils.showConnectionBanner(message: message, backgroundColor: color);
  }

  @override
  void onClose() {
    _connectionListener.cancel();
    super.onClose();
  }
}
