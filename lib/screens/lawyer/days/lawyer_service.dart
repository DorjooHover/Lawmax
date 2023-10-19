import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class LawyerSelectServiceView extends StatefulWidget {
  const LawyerSelectServiceView({super.key});

  @override
  State<LawyerSelectServiceView> createState() =>
      _LawyerSelectServiceViewState();
}

class _LawyerSelectServiceViewState extends State<LawyerSelectServiceView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerController());
    final primeController = Get.put(PrimeController());
    return Scaffold(
        appBar: PrimeAppBar(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Боломжит цаг сонгох'),
        backgroundColor: bg,
        body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: origin,
                right: origin),
            height: MediaQuery.of(context).size.height,
            child: LawyerServiceWidget(
              isBtn: false,
              onPress: () {},
              children: [
                space32,
                Text(
                  'Үйлчилгээгээ сонгоно уу',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                space32,
                Column(
                    children: primeController.services
                        .map((service) => GestureDetector(
                              onTap: () {
                                controller.availableTime.value?.service =
                                    service.sId;
                               Get.toNamed(Routes.lawyerServiceType);
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: small),
                                  child:
                                      ServiceCard(text: service.title ?? '')),
                            ))
                        .toList()),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 106,
                )
              ],
            )));
  }
}
