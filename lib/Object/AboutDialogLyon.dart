import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
 
class AboutDialogLyon extends StatelessWidget {
  final String applicationName;
  final String applicationVersion;
  final Widget applicationIcon;
  final String applicationLegalese;
  final List<Widget> children;



  AboutDialogLyon({
    Key key,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final String name = applicationName ?? tr('app_name');
    final String version = applicationVersion ?? tr('version');
    final Widget icon = applicationIcon ?? Icon(Icons.settings_applications);
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null)
                SizedBox(
                  height: 50.0, width: 50.0,
                  child:  IconTheme(data: Theme.of(context).iconTheme, child: icon),
                ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListBody(
                    children: <Widget>[
                      Text(name, style: Theme.of(context).textTheme.headline6,maxLines: 1,),
                      Text(version, style: Theme.of(context).textTheme.bodyText2,maxLines: 1),
                      Container(height: 18.0),
                      Text(applicationLegalese ?? '', style: Theme.of(context).textTheme.caption,maxLines: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ...?children,
        ],
      ),
      actions: <Widget>[
//        FlatButton(
//          child: Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
//          onPressed: () {
//            showLicensePage(
//              context: context,
//              applicationName: applicationName,
//              applicationVersion: applicationVersion,
//              applicationIcon: applicationIcon,
//              applicationLegalese: applicationLegalese,
//            );
//          },
//        ),
        FlatButton(
          child: Text(tr('close')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          onPressed: (){
            send();
          },
          icon: Icon(Icons.mail),
        ),
        ],
      scrollable: true,
    );
  }

  void send() async {
    List<String> to = ['lejiteyu@gmail.com'];
    List<String> cc = [''];
    List<String> bcc = [''];
    String subject = tr('app_name') + ' ' + applicationVersion;
    String body = '';
    if (Platform.isAndroid) {
      Email email = Email(
          to: to,
          cc: cc,
          bcc: bcc,
          subject: subject,
          body: body);
      await EmailLauncher.launch(email);
    }else if (Platform.isIOS) {
      var mail = to[0];
      var sub = subject.replaceAll(" ", "%20");
      var boddy = body.replaceAll(" ", "%20");
      var _launched = _openUrl('mailto:$mail?subject=$sub&body=$boddy');
    }
  }

  Future<void> _launched;

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}