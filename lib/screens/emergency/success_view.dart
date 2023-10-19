import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            space32,
            Column(
              children: [
                SvgPicture.asset(
                  iconSuccess,
                  width: 96,
                ),
                space32,
                space16,
                Text(
                  "Амжилттай",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                space16,
                Text(
                  'Төлбөр амжилттай төлөгдлөө',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                space32,
                // space4,
                // Text(
                //   'Байршил',
                //   textAlign: TextAlign.center,
                // ),
                // Text(
                //   location,
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.displaySmall,
                // ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: origin),
                  width: double.infinity,
                  child: MainButton(
                    onPressed: () {
                      Get.toNamed(Routes.home);
                    },
                    text: "Буцах",
                    // text: "Байршил харах",
                    child: const SizedBox(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 50),
                  width: double.infinity,
                  child: MainButton(
                    onPressed: () {
                  
                      if (controller.emergencyOrder.value != null) {
                        if (type == 'onlineEmergency') {
                          controller.getChannelToken(
                              controller.emergencyOrder.value!, false, '');
                        }
                      }
                    },
                    text: type == 'onlineEmergency'
                        ? "Дуудлага эхлүүлэх"
                        : "Байршил харах",
                    // text: "Байршил харах",
                    child: const SizedBox(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
