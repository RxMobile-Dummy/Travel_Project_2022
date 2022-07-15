import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationViewWidet extends StatefulWidget {
  LocationViewWidet(
      {Key? key,
      required this.lat,
      required this.log,
      required this.titleName,
      required this.mapHeight})
      : super(key: key);
  final double lat;
  final double log;
  final String titleName;
  final double mapHeight;
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
        CameraPosition(target: LatLng(widget.lat, widget.log), zoom: 5.4746);

    _list = [
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(widget.lat, widget.log),
          infoWindow: InfoWindow(title: widget.titleName))
    ];
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.mapHeight,
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
