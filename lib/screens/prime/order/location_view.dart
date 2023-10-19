import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:location/location.dart';

class ChooseLocationView extends StatefulWidget {
  const ChooseLocationView({Key? key}) : super(key: key);
  @override
  State<ChooseLocationView> createState() => ChooseLocationViewState();
}

class ChooseLocationViewState extends State<ChooseLocationView> {


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
    final controller = Get.put(PrimeController());
    return MapsWidget(
        step: 0,
        title: 'Байршил сонгох',
        navigator: () async {
         
            Get.toNamed(Routes.orderTime);
          
        },
        child: Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  top: large, right: origin, left: origin, bottom: origin),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(medium),
                      topRight: Radius.circular(medium))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: gold,
                        size: 38,
                      ),
                      space16,
                      Flexible(
                          child: Text(
                        'Байршил зөвхөн Улаанбаатар хотод дотор байх ёстойг анхаарна уу',
                        style: Theme.of(context).textTheme.displayMedium,
                      ))
                    ],
                  ),
                  space32,
                  MainButton(
                    width: double.infinity,
                    onPressed: () async {
                     
            Get.toNamed(Routes.orderTime);
          
                    },
                    // disabled: !controller.personal.value,
                    text: "Үргэлжлүүлэх",
                    child: const SizedBox(),
                  )
                ],
              ),
            )),
        onTap: (p0) {
          controller.selectedLocation.value?.lat = p0.latitude;
          controller.selectedLocation.value?.lng = p0.longitude;
        });
  }
}
