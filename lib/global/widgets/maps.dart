import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawmax/global/global.dart';
import 'package:location/location.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.child,
      required this.step,
      required this.navigator})
      : super(key: key);
  final String title;
  final Function(LatLng) onTap;
  final Function() navigator;
  final Widget? child;
  final int step;
  @override
  State<MapsWidget> createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> {
  List<Marker> marker = [];
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
      appBar: PrimeAppBar(
          bar: true,
          step: widget.step,
          onTap: () {
            Navigator.of(context).pop();
          },
          title: widget.title),
      body: currentLocation == null
          ? const Center(
              child: Text('Уншиж байна...'),
            )
          : Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                      zoom: 15,
                    ),
                    mapType: MapType.hybrid,
                    markers: Set.from(marker),
                    onTap: (argument) {
                      _handleTap(argument);
                    },
                  ),
                ),
                widget.child ??
                    Positioned(
                        bottom: MediaQuery.of(context).padding.bottom ,
                        left: 0,
                        right: 0,
                        child: MainButton(
                          onPressed: widget.navigator,
                          // disabled: !controller.personal.value,
                          text: "Үргэлжлүүлэх",
                          child: const SizedBox(),
                        ))
              ],
            ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    widget.onTap(tappedPoint);
    setState(() {
      marker = [];
      marker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
      ));
    });
  }
}
