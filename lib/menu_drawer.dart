

import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';

import 'Object/AboutDialogLyon.dart';

String _appVersion = '0.0.0';

class MenuStatefulWidget extends StatefulWidget {
  MenuStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<MenuStatefulWidget> {
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
      ],
    );
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





}