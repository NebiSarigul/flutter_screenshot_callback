import 'package:screenshot_callback_fix/plugin/pigeon.g.dart';

class ScreenShotCallbackFlutterApiImp extends ScreenShotCallbackFlutterApi {
  final Function()? onScreenShotCallback;

  ScreenShotCallbackFlutterApiImp({
    required this.onScreenShotCallback,
  });

  @override
  void screenShotCallback() {
    onScreenShotCallback?.call();
  }
}
