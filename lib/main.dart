import 'dart:async';
import 'dart:io';

import 'package:ads/ads.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'GoogleADMob/GAD.dart';
import 'Object/AboutDialogLyon.dart';
import 'Permission.dart';
import 'menu_drawer.dart';

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    // 支持的语言
    supportedLocales: [Locale('zh', 'CN')],
    // 语言资源包目录
    path: 'resources/langs',
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      //導入語言包
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapSample(title: tr('app_name')),
    );
  }
}
class MapSample extends StatefulWidget {
  MapSample({Key key, this.title}) : super(key: key);

  final String title;
  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _NH220 = CameraPosition(
      target: LatLng(25.0754409,121.5729122),
      zoom: 17);
  static final CameraPosition _NH468 = CameraPosition(
      target: LatLng(25.078472, 121.569555),
      zoom: 17);
  BitmapDescriptor _markerIcon;
  BitmapDescriptor pinLocationIcon ;
  BitmapDescriptor lakeMarkerIcon ;
  Set <Marker> _markers = {

  };
  LatLng _lastTap;
  
  void setCustomMapPin() async {
    if (Platform.isIOS) {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/iOS/purper_icon/60.png');
      lakeMarkerIcon = pinLocationIcon;
      _markerIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/iOS/fet/60.png');
    }
    else {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/images/puper_icon.png');
      lakeMarkerIcon = pinLocationIcon;
      _markerIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/images/fet.png');
    }
   
  }
  @override
  void initState(){
    GAD(initOption:3);
    getPermission();
    if (Platform.isIOS) {
      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 1.5),
          'resources/images/purple2.png').then((onValue) {
        pinLocationIcon = onValue;
      });
      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 1.5),
          'resources/images/fet.png').then((onValue) {
        _markerIcon = onValue;
      });
    }else{
      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/images/puper_icon.png').then((onValue) {
        pinLocationIcon = onValue;
      });
      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'resources/images/fet.jpeg').then((onValue) {
        _markerIcon = onValue;
      });
    }
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _markers.addAll([
        Marker(
            markerId: MarkerId("marker_Google"),
            position: _kGooglePlex.target,
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: "This is Google!",
            ),
        ),
          Marker(
              markerId: MarkerId("marker_Lake"),
              position: _kLake.target,
              icon: lakeMarkerIcon
          ),
          Marker(
              markerId: MarkerId("marker_nh220"),
              position: _NH220.target,
              icon: _markerIcon,
              onTap: (){
                showMyMaterialDialog(context);
              },
              infoWindow: InfoWindow(
                title: "This is FET!",
                  snippet: "NH220 大樓"
              ),
          ),
        Marker(
          markerId: MarkerId("marker_nh468"),
          position: _NH468.target,
          icon: _markerIcon,
          infoWindow: InfoWindow(
              title: "This is FET!",
              snippet: "NH468 大樓"
          ),
        )
      ]);
    });
    Widget menuWidget = MenuStatefulWidget(controller:_controller);

    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child:menuWidget
      ),
      body: Center(
        child:
        GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers:_markers,
          onTap: (LatLng pos){
             setState(() {
               _lastTap = pos;
               _markers.add(
                   Marker(
                     markerId: MarkerId("marker_touch"),
                     position: _lastTap,
                   )
               );
             });
           
          },
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToTheNH220() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_NH220));
  }

  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AboutDialogLyon(
            applicationName:'遠傳電信',
            applicationVersion:'FET NH220',
            applicationIcon:Image.asset('resources/images/fet.jpeg'),
            children: <Widget>[
              Text(tr('title'),style: TextStyle(fontSize: 30),)
            ],
          );
        });
  }


  Future<void> getPermission()async {
    Permission().requestPermission(context).then((value) => (){
      if(value){
        Permission().getLocation().then((value) =>()
        {
          print('my location:$value');
        });
      }else{

      }
    });
  }

  
 
}
