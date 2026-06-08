import Flutter
import UIKit

public class ScreenshotCallbackPlugin: NSObject, FlutterPlugin {
  static var channel: FlutterMethodChannel?

  static var observer: NSObjectProtocol?;


  public static func register(with registrar: FlutterPluginRegistrar) {
    channel  = FlutterMethodChannel(name: "flutter.moum/screenshot_callback", binaryMessenger: registrar.messenger())
    observer = nil;
    let instance = ScreenshotCallbackPlugin()
    if let channel = channel {
      registrar.addMethodCallDelegate(instance, channel: channel)
    }

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "initialize"){
        if(ScreenshotCallbackPlugin.observer != nil) {
            NotificationCenter.default.removeObserver(ScreenshotCallbackPlugin.observer!);
            ScreenshotCallbackPlugin.observer = nil;
        }
        ScreenshotCallbackPlugin.observer = NotificationCenter.default.addObserver(
          forName: UIApplication.userDidTakeScreenshotNotification,
          object: nil,
          queue: .main) { notification in
          if let channel = ScreenshotCallbackPlugin.channel {
            channel.invokeMethod("onCallback", arguments: nil)
          }

          result("screen shot called")
      }
      result("initialize")
    }else if(call.method == "dispose"){
        if(ScreenshotCallbackPlugin.observer != nil) {
            NotificationCenter.default.removeObserver(ScreenshotCallbackPlugin.observer!);
            ScreenshotCallbackPlugin.observer = nil;
        }
        result("dispose")
    }else{
      result("")
    }
  }

  deinit {
      if(ScreenshotCallbackPlugin.observer != nil) {
          NotificationCenter.default.removeObserver(ScreenshotCallbackPlugin.observer!);
          ScreenshotCallbackPlugin.observer = nil;
      }
  }
}
