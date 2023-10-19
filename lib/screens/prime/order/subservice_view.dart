import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';


class SubServiceView extends GetView<PrimeController> {
  const SubServiceView({
    super.key,
    this.title,
    this.description,
  });
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        appBar: PrimeAppBar(
          title: 'Дэлгэрэнгүй',
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.only(
                  bottom: origin, left: origin, right: origin),
              height: defaultHeight(context) + 80,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon(Icons.error),
                        title != '' ? space16 : const SizedBox(),
                        title != ''
                            ? Text(
                                title!,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            : const SizedBox(),
                        description != '' ? space16 : const SizedBox(),
                        description != ''
                            ? Text(
                                description!,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )
                            : const SizedBox(),
                        space32,
                        Text(
                          'Санал болгож буй хуульчид',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        space16,
                        Flexible(
                            child: Obx(
                          () => controller.loading.value
                              ? SizedBox(
                                  height: 200,
                                  child: Container(),
                                )
                              // ? SizedBox(
                              //     height: 200,
                              //     child: SkeletonListView(),
                              //   )
                              : ListView.builder(
                                  itemCount: controller.lawyers.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () async {
                                          // Navigator.of(context).push(
                                          //     createRoute(
                                          //         const OrderLawyerView()));
                                          controller.selectedLawyer.value =
                                              controller.lawyers[index];

                                          controller.selectedLawyer.value =
                                              controller.lawyers[index];
                                          // final date = controller
                                          //     .lawyers[index].userServices
                                          //     ?.firstWhere((ser) =>
                                          //         ser.serviceId ==
                                          //         controller
                                          //             .selectedService.value);

                                          // controller.selectedDate.value = DateTime
                                          //     .fromMillisecondsSinceEpoch(date
                                          //             ?.serviceTypes
                                          //             ?.first
                                          //             .time
                                          //             ?.first
                                          //             .date ??
                                          //         DateTime.now()
                                          //             .millisecondsSinceEpoch);
                                        },
                                        child: MainLawyer(
                                            bg: Colors.white,
                                            user: controller.lawyers[index]));
                                  },
                                ),
                        )),

                        space64
                      ]),
                  title != ''
                      ? Positioned(
                          bottom: MediaQuery.of(context).padding.bottom  ,
                          left: 16,
                          right: 16,
                          child: MainButton(
                            onPressed: () {
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  const OrderBottomSheet(
                                    title: 'Захиалгын төрөл сонгоно уу',
                                  ));
                            },
                            text: "Захиалга",
                            child: const SizedBox(),
                          ))
                      : const SizedBox()
                ],
              )),
        ));
  }
}
