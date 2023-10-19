import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/provider.dart';
import 'package:lawmax/routes.dart';
import 'package:location/location.dart';


class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage(
      {Key? key, required this.location, this.child})
      : super(key: key);

  final LocationDto location;
  final Widget? child;
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isLawyer = false;
  Util util = Util();
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  ApiRepository apiRepository = ApiRepository();
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  final controller = Get.put(HomeController());
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    // GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newLoc) {
      if (isLawyer) {
        apiRepository.updateLawyerLocation(
            LocationDto(lat: newLoc.latitude, lng: newLoc.longitude));
      }
      setState(() {
        currentLocation = newLoc;
      });
    });
  }

  void moveCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!), 14));
  }

  void moveOtherLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(widget.location.lat!, widget.location.lng!), 14));
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
  print(widget.location.lat);
  print(widget.location.lng);
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     "AIzaSyBFjNwmF1AqkveFmiHternBhJ9Ic2xxrN0",
    //     PointLatLng(widget.location.lat!, widget.location.lng!),
    //     PointLatLng(destination.latitude, destination.longitude));
    // if (result.points.isNotEmpty) {
    //   for (var point in result.points) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   }
    // }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    addCustomIcon();
    setState(() {
      isLawyer = controller.currentUserType.value != UserTypes.user; 
    });
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Location_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimeAppBar(
          onTap: () {
                Get.toNamed(Routes.home);
          },
          title: 'Байршил харах'),
      body: currentLocation == null
          ? const Center(
              child: Text('Уншиж байна...'),
            )
          : Stack(
              children: [
                SizedBox(
                  height: defaultHeight(context) + 84,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                      zoom: 13.5,
                    ),
                    polylines: {
                      Polyline(
                          polylineId: const  PolylineId("route"),
                          points: polylineCoordinates,
                          color: primary,
                          width: 6)
                    },
                    markers: {
                      Marker(
                        markerId: const  MarkerId("currentLocation"),
                        position: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                      ),
                      Marker(
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        markerId: const MarkerId("source"),
                        position:
                            LatLng(widget.location.lat!, widget.location.lng!),
                      ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
                ),
                widget.child ??
                    Positioned(
                        bottom: MediaQuery.of(context).padding.bottom,
                        left: origin,
                        right: origin,
                        child: MainButton(
                          onPressed: () {
                             Get.toNamed(Routes.home);
                          },
                          // disabled: !controller.personal.value,
                          text: "Буцах",
                          child: const SizedBox(),
                        )),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 80,
                    right: origin,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          moveCurrentLocation();
                        },
                        icon: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Positioned(
                    top: 20,
                    left: origin,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100)),
                          width: 10,
                          height: 10,
                        ),
                        space8,
                        Text(
                          isLawyer ? "Хэрэглэгч" : 'Хуульч',
                        )
                      ],
                    )),
                Positioned(
                    top: 40,
                    left: origin,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                          width: 10,
                          height: 10,
                        ),
                        space8,
                        Text(
                          !isLawyer ? "Миний" : 'Хуульч',
                        )
                      ],
                    )),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 140,
                    right: origin,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {
                          moveOtherLocation();
                        },
                        icon: const Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
    );
  }
}
