import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  GoogleMapController _controller;

  GoogleMapPolyline _googleMapPolyline =
      new GoogleMapPolyline(apiKey: "YOUR KEY HERE");

  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[ //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  LatLng _mapInitLocation = LatLng(40.683337, -73.940432);

  LatLng _originLocation = LatLng(40.677939, -73.941755);
  LatLng _destinationLocation = LatLng(40.698432, -73.924038);

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  //Get polyline with Location (latitude and longitude)
  _getPolylinesWithLocation() async {
    List<LatLng> _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: _originLocation,
            destination: _destinationLocation,
            mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
  }

  //Get polyline with Address
  _getPolylinesWithAddress() async {
    List<LatLng> _coordinates =
        await _googleMapPolyline.getPolylineCoordinatesWithAddress(
            origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
            destination: '8007 Cypress Ave, Glendale, NY 11385, USA',
            mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
  }

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Map Polyline'),
          ),
          body: Container(
            child: LayoutBuilder(
              builder: (context, cont) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 175,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        polylines: Set<Polyline>.of(_polylines.values),
                        initialCameraPosition: CameraPosition(
                          target: _mapInitLocation,
                          zoom: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                child: Text('Polylines wtih Location'),
                                onPressed: _getPolylinesWithLocation,
                              ),
                              RaisedButton(
                                child: Text('Polylines wtih Address'),
                                onPressed: _getPolylinesWithAddress,
                              ),
                            ],
                          )),
                    ),
                  ],
                );
              },
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
