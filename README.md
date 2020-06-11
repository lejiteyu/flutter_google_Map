# map

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# flutter_google_Map

Step1. 添加Google Maps Flutter plugin
和之前Day25-在iPhone上實現Video Player添加video_player plugin的做法一樣在pubspec.yaml加入google map plugin dependencies

dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^0.5.11  //加這行
  
Step2. 取得Google Map API key
 可參考https://ithelp.ithome.com.tw/articles/10227736
  
Step3. 添加API key
iOS:
iOS添加API key，我們需要編輯ios/Runner/AppDelegate.swift文件
加入以下代碼，要記得補上剛剛申請的API key

      import GoogleMaps //加這行

      @UIApplicationMain
      @objc class AppDelegate: FlutterAppDelegate {
        override func application(
          _ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
          GeneratedPluginRegistrant.register(with: self)
          GMSServices.provideAPIKey("YOUR_API_KEY")  //加這行
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
      }
      
編輯ios/Runner/Info.plist文件，<dict>裡加入以下
請注意 下面兩行都要加入
  
      <key>io.flutter.embedded_views_preview</key>
      <true/>

Android:
  Android添加API key，我們需要編輯android/app/src/main/AndroidManifest.xml文件
 
          <manifest ...
          
           <!--    Google Map 需要手動增加下面兩個 uses-permission-->
          <uses-permission android:name="android.permission.INTERNET" />
          <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
          
          <application ...
              <meta-data android:name="com.google.android.geo.API_KEY"
                         android:value="YOUR KEY HERE"/>
                         ........
                         
 這樣前置作業就完成了！                        
  
  
