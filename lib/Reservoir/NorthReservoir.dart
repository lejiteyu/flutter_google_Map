import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/camera.dart';
import 'package:map/Reservoir/Reservoir_point.dart';


typedef GoToCallBack = void Function(CameraPosition position, String MarkerId);

class NorthReservoir extends StatelessWidget {
  GoToCallBack GoTo;
  NorthReservoir( {
    this.GoTo,
  });

  @override
  Widget build(BuildContext context) {
   return
     SizedBox(
       child:Center(
         child: Column(
           children: [
             Text(
                 '北部水庫'
             ),
             ListTile(
               leading: Icon(Icons.place),
               title: Text('Google'),
               onTap: () {
                 Navigator.of(context).pop();
                 GoTo(Reservoir_point().getGoogle(),"marker_google");
               },
             ),
             ListTile(
               leading: Icon(Icons.place),
               title: Text('NH220'),
               onTap: () {
                 Navigator.of(context).pop();
                 GoTo(Reservoir_point().getNH220(),"marker_nh220");
               },
             ),
             ListTile(
               leading: Icon(Icons.place),
               title: Text('NH468'),
               onTap: () {
                 Navigator.of(context).pop();
                 GoTo(Reservoir_point().getNH468(),"marker_nh468");
               },
             ),
           ],
         ),
       )
     );
  }
}


