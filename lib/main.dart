import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  BitmapDescriptor _markerIcon;


  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child:MenuStatefulWidget()
      ),
      body: Center(
        child:
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng pos){
            _goToTheLake();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheNH220,
        label: Text('To the NH220!'),
        icon: Icon(Icons.directions_car),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    _createMarker(_kLake.target);
  }

  Future<void> _goToTheNH220() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_NH220));
    _createMarker(_NH220.target);
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'images/maker.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  Set<Marker> _createMarker(LatLng latLng) {
    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
    // https://github.com/flutter/flutter/issues/28312
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: latLng,
        icon: _markerIcon,
      ),
    ].toSet();
  }
}
