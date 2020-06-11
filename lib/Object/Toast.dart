
import 'package:flutter/material.dart';

class Toast{
  BuildContext context;
  String title;
  String msg;
  Toast({this.context,this.msg});
  show() async{
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 200.0,
              width: 200.0,
              color: const Color(0x55ffffff),
              child: Container(
                alignment: Alignment.center,
                child: Text(msg),
              )
          );
        });
    }
}