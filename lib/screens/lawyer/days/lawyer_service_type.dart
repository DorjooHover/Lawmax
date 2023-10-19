import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class LawyerServiceTypeView extends StatefulWidget {
  const LawyerServiceTypeView({super.key});

  @override
  State<LawyerServiceTypeView> createState() => _LawyerServiceTypeViewState();
}

class _LawyerServiceTypeViewState extends State<LawyerServiceTypeView> {
  final List<int> selectedDays = [];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerController());

    return Scaffold(
        appBar: PrimeAppBar(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Боломжит цаг сонгох'),
        backgroundColor: bg,
        body: Container(
            padding: const EdgeInsets.symmetric(
           horizontal: origin),
            height: MediaQuery.of(context).size.height,
            child: LawyerServiceWidget(
              submitText: 'Үргэлжлүүлэх',
              onPress: () {
                try {
                  if (controller.selectedType.isNotEmpty) {
                    Get.toNamed(Routes.lawyerAvailableDays);
                  } else {
                    Get.snackbar('Алдаа', 'Үйлчилгээ сонгоно уу');
                  }
                } catch (e) {
                  // Get.snackbar('Алдаа', 'Үйлчилгээ сонгоно уу');
                }
              },
              children: [
                space32,
                Text(
                  'Үйлчилгээ үзүүлэх төрлөө сонгоно уу',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                space32,
                Column(
                    children: serviceTypes
                        .map((service) => Obx(() => GestureDetector(
                              onTap: () {
                                if (controller.selectedType
                                        .firstWhere(
                                            (element) =>
                                                service['id'] == element.type,
                                            orElse: () => TimeType(type: ""))
                                        .type ==
                                    "") {
                                  controller.selectedType.add(TimeType(
                                      type: service['id'],
                                      expiredTime: 30,
                                      price: 50000));
                                } else {
                                  controller.selectedType.removeWhere(
                                      (element) =>
                                          element.type == service['id']!);
                                }
                              },
                              child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: small),
                                  padding: const EdgeInsets.all(origin),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(origin),
                                      color: controller.selectedType
                                                  .firstWhere((element) => service['id'] == element.type,
                                                      orElse: () =>
                                                          TimeType(type: ""))
                                                  .type ==
                                              ""
                                          ? Colors.white
                                          : primary),
                                  child: Text(service['value']!.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color:
                                                  controller.selectedType.firstWhere((element) => service['id'] == element.type, orElse: () => TimeType(type: '')).type != ''
                                                      ? Colors.white
                                                      : primary))),
                            )))
                        .toList()),
               
              ],
            )));
  }
}
