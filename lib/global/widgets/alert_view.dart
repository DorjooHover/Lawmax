import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';


import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';



class AlertView extends StatelessWidget {
  const AlertView({super.key, required this.status, required this.text});
  final String status;
  final String text;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 50),
              width: double.infinity,
              child: MainButton(
                onPressed: () {
                controller.currentIndex.value = 0;
                 Get.toNamed(Routes.home);
                },
                text: "Үндсэн цэс рүү буцах",
                child: const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
