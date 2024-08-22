import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:screenshot_callback_fix/plugin/pigeon.g.dart';
import 'package:screenshot_callback_fix/plugin/screenshot_callback_fix_plugin.dart';

class ScreenshotCallbackFix {
  ScreenShotCallbackFlutterApiImp? flutterApi;
  ScreenShotCallbackHostApi? hostApi;

  List<VoidCallback> onCallbacks = <VoidCallback>[];

  ScreenshotCallbackFix() {
    hostApi = ScreenShotCallbackHostApi();
    hostApi?.initialize();
    // listener screenshot callback.
    flutterApi = ScreenShotCallbackFlutterApiImp(
      onScreenShotCallback: () {
        for (final callback in onCallbacks) {
          callback();
        }
      },
    );
    ScreenShotCallbackFlutterApi.setup(flutterApi);
  }

  /// Add void callback.
  void addListener(VoidCallback callback) {
    onCallbacks.add(callback);
  }

  /// Remove callback listener.
  Future<void> dispose() async {
    final hostApi = this.hostApi;
    if (hostApi == null) return;
    return await hostApi.dispose();
  }
}
