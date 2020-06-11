import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog{
  BuildContext context;
  LoadingDialog({this.context});
  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return new LoadingDialoglessWidget();
        });
  }

  void dismiss(){
    Navigator.of(context).pop();
  }
}

class LoadingDialoglessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;
    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)));
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
//在這裡修改成我們想要顯示的widget就行了，外部的屬性跟其他Dialog保持一致
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: new Text(tr('loading')),
                  ),
                ],
              ),
              shape: _defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }
}