import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineRequestData {
  LatLng originLoc;
  LatLng destinationLoc;
  String originText;
  String destinationText;
  RouteMode mode;
  bool locationText;
  String apiKey;

  PolylineRequestData({
    this.originLoc,
    this.destinationLoc,
    this.originText,
    this.destinationText,
    this.mode,
    this.locationText,
    this.apiKey,
  });
}

enum RouteMode {
  driving,
  walking,
  bicycling,
}
