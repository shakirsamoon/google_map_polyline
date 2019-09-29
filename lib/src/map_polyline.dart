import 'package:flutter/foundation.dart';
import 'package:google_map_polyline/src/route_mode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/src/polyline_request.dart';
import 'package:google_map_polyline/src/polyline_utils.dart';

/// Gives polyline coordinates to set polylines in Google Map.
class GoogleMapPolyline {
  String apiKey;
  GoogleMapPolyline({@required this.apiKey});

  PolylineUtils _utils;
  PolylineRequestData _data;

  /// Get coordinates using Location Coordinates
  /// Example : LatLng(40.677939, -73.941755)
  Future<List<LatLng>> getCoordinatesWithLocation({
    @required LatLng origin,
    @required LatLng destination,
    @required RouteMode mode,
  }) async {
    _data = new PolylineRequestData(
        originLoc: origin,
        destinationLoc: destination,
        mode: mode,
        locationText: false,
        apiKey: apiKey);

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }

  /// Get coordinates using Location Coordinates
  /// Example : '55 Kingston Ave, Brooklyn, NY 11213, USA'
  Future<List<LatLng>> getPolylineCoordinatesWithAddress({
    @required String origin,
    @required String destination,
    @required RouteMode mode,
  }) async {
    _data = new PolylineRequestData(
        originText: origin,
        destinationText: destination,
        mode: mode,
        locationText: true,
        apiKey: apiKey);

    _utils = new PolylineUtils(_data);

    return await _utils.getCoordinates();
  }
}
