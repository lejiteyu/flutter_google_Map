import UIKit
import Flutter
import GoogleMaps //加這行

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Add the following line, with your API key
    GMSServices.provideAPIKey("AIzaSyAkmD0SPtwk-HBPx3M7epd0fp9kVlGe21s")//加這行
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
