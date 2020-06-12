

import 'dart:async';
import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';

import 'Object/AboutDialogLyon.dart';
import 'main.dart';

String _appVersion = '0.0.0';

class MenuStatefulWidget extends StatefulWidget {
  MenuStatefulWidget({Key key, this.title, this.controller}) : super(key: key);
  final String title;
  final Completer<GoogleMapController> controller;
  @override
  _ParentWidgetState createState() => new _ParentWidgetState(controller:controller);
}

class _ParentWidgetState extends State<MenuStatefulWidget> {
  var controller;
  _ParentWidgetState({this.controller});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('Lyon flutter make app'),
          accountEmail: Text(_appVersion),
          currentAccountPicture: Image.asset(
              'resources/images/lyonhsu3_t.png',
              width: 50,
              height: 50,
              fit:BoxFit.fill  ),
          decoration: BoxDecoration(color: Colors.grey),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(tr('about_Me')),
          onTap: () {
            Navigator.pop(context);
            showMyMaterialDialog(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text(tr('menu_score')),
          onTap: () {
            try{
              /**
               *  if no work
               *  please
               *  1.uninstall your apps
               *  2.run flutter clean
               *  3.reinstall app
               */
              LaunchReview.launch(
                androidAppId: "lyon.calculator.lyoncalculator",
                iOSAppId: "585027354",
              );
            }catch (e){
              print(e);
            }

            Navigator.pop(context);
          },
        ),
        new Divider(),    //分割线控件
        ListTile(
          leading: Icon(Icons.place),
          title: Text('NH220'),
          onTap: () {
            Navigator.of(context).pop();
            _goTo(_NH220,"marker_nh220");
          },
        ),
        ListTile(
          leading: Icon(Icons.place),
          title: Text('NH4689'),
          onTap: () {
            Navigator.of(context).pop();
            _goTo(_NH468,"marker_nh468");
          },
        ),
      ],
    );
  }

  static final CameraPosition _NH220 = CameraPosition(
      target: LatLng(25.0754409,121.5729122),
      zoom: 17);
  static final CameraPosition _NH468 = CameraPosition(
      target: LatLng(25.078472, 121.569555),
      zoom: 17);

  Future<void> _goTo(CameraPosition pos,String markerId) async {
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(pos));
    c.showMarkerInfoWindow(MarkerId(markerId));
  }

  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AboutDialogLyon(
              applicationName:tr('app_name'),
              applicationVersion:_appVersion,
              applicationIcon:Image.asset('resources/images/lyonhsu3_t.png'),
            children: <Widget>[
              Text(tr('title'),style: TextStyle(fontSize: 30),)
            ],
          );
        });
  }

  Future initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var localVersion = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    print('initVersion() localVersion:$localVersion buildNumber=$buildNumber');
    setState(() {
      _appVersion = 'ver:$localVersion($buildNumber)';
    });
  }


  Future setGoToNH220() async{

  }




}