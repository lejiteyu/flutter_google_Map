import 'package:google_maps_flutter/google_maps_flutter.dart';

class Reservoir_point{
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _NH220 = CameraPosition(
      target: LatLng(25.0754409,121.5729122),
      zoom: 17);
  static final CameraPosition _NH468 = CameraPosition(
      target: LatLng(25.078472, 121.569555),
      zoom: 17);

  CameraPosition getGoogle(){
    return _kGooglePlex;
  }

  CameraPosition getNH220(){
    return _NH220;
  }

  CameraPosition getNH468(){
    return _NH468;
  }
}