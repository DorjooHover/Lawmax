import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawmax/global/global.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentLocation == null
            ? const Center(
                child: Text('Уншиж байна...'),
              )
            : Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: origin,
                    right: origin),
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            zoom: 13.5,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("currentLocation"),
                              position: LatLng(currentLocation!.latitude!,
                                  currentLocation!.longitude!),
                            )
                          },
                          onMapCreated: (mapController) {
                            _controller.complete(mapController);
                          },
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: MediaQuery.of(context).padding.bottom + 50,
                        left: 0,
                        right: 0,
                        child: MainButton(
                          onPressed: () {
                            // controller.sendOrder(context);
                          },
                          text: "Үргэлжлүүлэх",
                          child: const SizedBox(),
                        ))
                  ],
                ),
              ));
  }
}
