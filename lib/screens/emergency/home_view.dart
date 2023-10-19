import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';

import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class EmergencyHomeView extends StatefulWidget {
  const EmergencyHomeView({super.key});

  @override
  State<EmergencyHomeView> createState() => _EmergencyHomeViewState();
}

class _EmergencyHomeViewState extends State<EmergencyHomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmergencyController());
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () async {
            // await controller.start();
          },
          child: Container(
            color: bg,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(
           
                children: [
                  EmergencyCard(
                expiredTime: 10,
                onTap: () {
                  controller.serviceType.value = 'onlineEmergency';
                  Get.toNamed(Routes.direction, arguments: onlineDirection);
                },
                price: 10000,
                icon: Icons.phone,
                title: 'Яаралтай дуудлага хийж  хуулийн зөвлөгөө авах',
                  ),
                  space16,
                  EmergencyCard(
                onTap: () {
                  controller.serviceType.value = 'fulfilledEmergency';
                  Get.toNamed(Routes.direction, arguments: fulfilledDirection);
                },
                expiredTime: 60,
                price: 100000,
                icon: Icons.person,
                title: 'Хуульч дуудаж хууль зүйн туслалцаа авах',
                  ),
                ],
              
            )),
          )),
    );
  }
}
