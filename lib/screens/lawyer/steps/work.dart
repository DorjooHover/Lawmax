import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class WorkView extends StatefulWidget {
  const WorkView({super.key});

  @override
  State<WorkView> createState() => _WorkViewState();
}

final workKey = GlobalKey<FormState>();

class _WorkViewState extends State<WorkView> {
  String work = '';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    return MapsWidget(
        step: 4,
        title: 'Ажлын газрын байршил',
        navigator: () {
          Get.toNamed(Routes.lawyerOffice);
        },
        child: Positioned(
            bottom: 0,
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
                  space16,
                  Form(
                    key: workKey,
                    child: Input(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та ажлын байршлаа оруулна уу';
                          }
                          return null;
                        },
                        onSubmitted: (p0) {
                          if (workKey.currentState!.validate() &&
                              controller.lawyer.value?.workLocation?.lat !=
                                  0.0) {
                          Get.toNamed(Routes.lawyerOffice);   }
                        },
                        value: controller.lawyer.value?.workLocationString,
                        onChange: (p0) {
                          setState(() {
                            work = p0;
                          });
                          controller.lawyer.value?.workLocationString = p0;
                        },
                        labelText: 'Ажлын хаягаа дэлгэрэнгүй бичнэ үү.'),
                  ),
                  space32,
                  MainButton(
                      width: double.infinity,
                      onPressed: () {
                        if (workKey.currentState!.validate()) {
                           Get.toNamed(Routes.lawyerOffice);    
                        }
                      },
                      disabled: work == '' ||
                          controller.lawyer.value?.workLocation?.lat == 0.0,
                      text: "Үргэлжлүүлэх",
                      child: const SizedBox(),
                    
                  ),
                  space32,
                ],
              ),
            )),
        onTap: (p0) {
          controller.lawyer.value?.workLocation?.lat = p0.latitude;
          controller.lawyer.value?.workLocation?.lng = p0.longitude;
        });
  }
}
