import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class OfficeView extends StatefulWidget {
  const OfficeView({super.key});

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

final officeKey = GlobalKey<FormState>();

class _OfficeViewState extends State<OfficeView> {
  String office = '';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    return MapsWidget(
        step: 5,
        title: 'Оффисын байршил',
        navigator: () {
         Get.toNamed(Routes.lawyerService);
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
                    key: officeKey,
                    child: Input(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та оффисын байршлаа оруулна уу';
                          }
                          return null;
                        },
                        onSubmitted: (p0) {
                          if (officeKey.currentState!.validate() &&
                              controller.lawyer.value?.officeLocation?.lat !=
                                  0.0) {
                        Get.toNamed(Routes.lawyerOffice);
                          }
                        },
                        value: controller.lawyer.value?.officeLocationString,
                        onChange: (p0) {
                          setState(() {
                            office = p0;
                          });
                          controller.lawyer.value?.officeLocationString = p0;
                        },
                        labelText: 'Оффисын хаягаа дэлгэрэнгүй бичнэ үү.'),
                  ),
                  space32,
                  MainButton(
                    width: double.infinity,
                    onPressed: () {
                      if (officeKey.currentState!.validate()) {
                        Get.toNamed(Routes.lawyerService);
                      }
                    },
                    disabled: office == '' ||
                        controller.lawyer.value?.officeLocation?.lat == 0.0,
                    text: "Үргэлжлүүлэх",
                    child: const SizedBox(),
                  ),
                  space32,
                ],
              ),
            )),
        onTap: (p0) {
          controller.lawyer.value?.officeLocation?.lat = p0.latitude;
          controller.lawyer.value?.officeLocation?.lng = p0.longitude;
        });
  }
}
