import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class Permission{

  Permission();



  Future getLocation() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var latlng=LatLng(position.latitude, position.longitude);
    return latlng;
  }

  Future requestPermission(BuildContext context) async {
    // 申请权限
    List<PermissionGroup> requestPermissions = [
      PermissionGroup.location,
      PermissionGroup.locationAlways,
      PermissionGroup.locationWhenInUse
    ];
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions(requestPermissions);

    // 申请结果  权限检测
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    bool isOk=false;
    if (permission == PermissionStatus.granted) {
      // 参数1：提示消息
      // 参数2：提示消息多久后自动隐藏
      // 参数3：位置
      isOk = true;
//      Toast.show(tr('permiss_success'), context,
//          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      isOk=false;
      Toast.show(tr('permiss_fail'), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      openSetting(context);
    }
    return isOk;
  }

  Future openSetting(BuildContext context) async{
    bool isOpened = await PermissionHandler().openAppSettings();
    if(isOpened){
      Toast.show("打开了设置页！", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }else{
      Toast.show("没打开！", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

}