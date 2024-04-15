import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TrackingMapScreen extends StatefulWidget {
  @override
  _TrackingMapScreenState createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends State<TrackingMapScreen> {
  GoogleMapController? _controller;
  Location _location = Location();
  List<LatLng> _points = [];

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _points.add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      });
      _updateMapCamera(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  void _updateMapCamera(double lat, double lng) {
    if (_controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rastreamento de Trajetória'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Coordenadas iniciais do mapa
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('track'),
            points: _points,
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }
}
