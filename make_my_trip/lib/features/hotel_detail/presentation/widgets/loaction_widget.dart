import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationViewWidet extends StatefulWidget {
  LocationViewWidet({
    Key? key,
    required this.lat,
    required this.log,
  }) : super(key: key);
  final double lat;
  final double log;
  @override
  State<LocationViewWidet> createState() => _LocationViewWidetState();
}

class _LocationViewWidetState extends State<LocationViewWidet> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _marker = [];

  late CameraPosition _kGooglePlex;
  late List<Marker> _list;

  @override
  void initState() {
    super.initState();

    _kGooglePlex =
        CameraPosition(target: LatLng(widget.lat, widget.log), zoom: 14.4746);

    _list = [
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(widget.lat, widget.log),
          infoWindow: InfoWindow(title: 'The title of the marker'))
    ];
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
