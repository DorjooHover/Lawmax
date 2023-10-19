import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:lawmax/screens/emergency/location_view.dart';

class AdditionView extends StatelessWidget {
  const AdditionView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmergencyController());
    return Scaffold(
        appBar: PrimeAppBar(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Нэмэлт мэдээлэл'),
        backgroundColor: bg,
        body: Container(
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
                  space32,
                  Input(
                    labelText: 'Уулзах шалтгаанаа бичиж оруулна уу',
                    onChange: (p0) => controller.reason.value = p0,
                  )
                ],
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom ,
                  left: 0,
                  right: 0,
                  child: Obx(() => MainButton(
                        loading: controller.loading.value,
                        onPressed: () async {
                          if (controller.serviceType.value ==
                              'onlineEmergency') {
                            await controller.sendOrder();
                          } else {
                            Get.to(() => const LocationView());
                          }
                        },
                        text: controller.serviceType.value == 'onlineEmergency'
                            ? "Төлбөр төлөх"
                            : 'Үргэлжлүүлэх',
                        child: const SizedBox(),
                      )))
            ],
          ),
        ));
  }
}
