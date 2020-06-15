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
  
  
  
  Permission
  請參考：
  https://blog.csdn.net/u013425527/article/details/98938611
  
  
  pubspec.yaml加入
  
      dependencies:
      flutter:
        sdk: flutter
      #    动态权限申请
      permission_handler: '^3.2.0'
      
  Android:
   Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 28:
   
        android {
          compileSdkVersion 28
          ...
        }
        
   在 gradle.properties
  
      android.enableJetifier=true
      android.useAndroidX=true
  
   android/app/src/main/AndroidManifest.xml文件
      
      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
      <uses-feature android:name="android.hardware.location.network" android:required="false" />
      <uses-feature android:name="android.hardware.location.gps" android:required="false"  />
      
  
  iOS:
     Add permission to your Info.plist
     
        <!-- permission 加入下面兩行 start-->
        <key>NSLocationWhenInUseUsageDescription</key>
        <string>When In Use Permission</string>
        <key>NSLocationAlwaysUsageDescription</key>
        <string>Always Permission</string>
        <key>NSLocationAlwaysAndWhenInUsageDescription</key>
        <string>Always And In Use Permission</string>
        <key>EnableBackgroundLocationUpdates</key>
        <true/>
        <!-- permission 加入下面兩行 end-->
       
  
  Google ADS Mob:
  
   pubspec.yaml加入
  
    #20200615 Google ADS
    firebase_admob: ^0.9.0+1
    ads: ^1.7.3
    
   Android:
  
   在 android/app/src/main/AndroidManifest.xml文件
  
      <manifest>
        <application>
            <!-- Sample AdMob App ID: ca-app-pub-3940256099942544~3347511713 -->
            <meta-data
                android:name="com.google.android.gms.ads.APPLICATION_ID"
                android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
            <meta-data
              android:name="com.google.android.gms.ads.AD_MANAGER_APP"
              android:value="true"/>
        </application>
       </manifest>
       
 android/build.gradle
 
       buildscript {
          .........

          dependencies {
             .........
              //#20200615 Google ADS  Add the following line:
              classpath 'com.google.gms:google-services:4.3.3'
          }
      }
      
      
      
  iOS:
    
   Info.plist  增加
    
     <!--20200615 Google ADS Google ADSMob 加入下面兩行 start-->
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-3940256099942544~1458002511</string>
    <key>io.flutter.embedded_views_preview</key>
    <true/>
    <!--20200615 Google ADS Google ADSMob 加入上面兩行 end-->
    
   去https://console.firebase.google.com/u/0/ 建立專案 下載 GoogleService-Info.plist
   使用XCode 將GoogleService-Info.plist 放入到Runner資料夾
   
      GoogleService-Info.plist
      
   下載 GoogleService-Info.plist 可參考 
   
    https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E8%A8%AD%E5%AE%9A-ios-app-%E7%9A%84-firebase-%E5%8A%9F%E8%83%BD-afcaaabe00f2 
   
   
   
