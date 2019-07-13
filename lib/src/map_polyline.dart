import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_map_polyline/src/polyline_request.dart';
import 'package:google_map_polyline/src/polyline_utils.dart';

class GoogleMapPolyline {
  String apiKey;
  GoogleMapPolyline({@required this.apiKey});

  PolylineUtils _utils;
  PolylineRequestData _data;

  Future<List<LatLng>> getCoordinatesWithLocation({
    @required LatLng origin,
    @required LatLng destination,
    @required RouteMode mode,
    bool alternatives = false,
  }) async {
    _data = await new PolylineRequestData(
        originLoc: origin,
        destinationLoc: destination,
        mode: mode,
        locationText: false,
        apiKey: apiKey);

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }

  Future<List<LatLng>> getPolylineCoordinatesWithAddress({
    @required String origin,
    @required String destination,
    @required RouteMode mode,
    bool alternatives = false,
  }) async {
    _data = await new PolylineRequestData(
        originText: origin,
        destinationText: destination,
        mode: mode,
        locationText: true,
        apiKey: apiKey);

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }
}
