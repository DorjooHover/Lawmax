import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';

class LawyerAvailableDay extends StatelessWidget {
  const LawyerAvailableDay({super.key, required this.day});

  final int day;

  @override
  Widget build(BuildContext context) {
  Util util = Util();
    final controller = Get.put(LawyerController());
    int currentDay = DateTime(controller.selectedDate.value.year,
            controller.selectedDate.value.month, day)
        .millisecondsSinceEpoch;
    int afterDay = DateTime(controller.selectedDate.value.year,
            controller.selectedDate.value.month, day + 1)
        .millisecondsSinceEpoch;
    List<String> availableTime = availableTimes
        .where((element) =>
            DateTime.now().millisecondsSinceEpoch + 10 * 60 <
            DateTime(
                    controller.selectedDate.value.year,
                    controller.selectedDate.value.month,
                    day,
                    int.parse(element.substring(0, 2)))
                .millisecondsSinceEpoch)
        .toList();
    if (availableTime.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: origin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Obx(() => Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.timeDetail
                                  .where((t) =>
                                      t.time! >= currentDay &&
                                      t.time! < afterDay)
                                  .isNotEmpty
                              ? Colors.black
                              : Colors.white),
                      child: Column(
                        children: [
                          space4,
                          Obx(
                            () => Text(
                              util.getDay(DateTime(
                                  controller.selectedDate.value.year,
                                  controller.selectedDate.value.month,
                                  day)),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: controller.timeDetail
                                              .where((t) =>
                                                  t.time! >= currentDay &&
                                                  t.time! < afterDay)
                                              .isNotEmpty
                                          ? Colors.white
                                          : primary),
                            ),
                          ),
                          space8,
                          Obx(
                            () => Text(
                              '$day',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: controller.timeDetail
                                              .where((t) =>
                                                  t.time! >= currentDay &&
                                                  t.time! < afterDay)
                                              .where((t) =>
                                                  t.time! >= currentDay &&
                                                  t.time! < afterDay)
                                              .isNotEmpty
                                          ? Colors.white
                                          : primary),
                            ),
                          ),
                          space4
                        ],
                      ),
                    ))),
            space8,
            Expanded(
                flex: 4,
                child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: small,
                    crossAxisSpacing: small,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: [
                      ...availableTime.map((e) {
                        int time = DateTime(
                                controller.selectedDate.value.year,
                                controller.selectedDate.value.month,
                                day,
                                int.parse(e.substring(0, 2)))
                            .millisecondsSinceEpoch;
                        if (time >
                            DateTime.now().millisecondsSinceEpoch + 10 * 60) {
                          return GestureDetector(
                              onTap: () {
                                if (controller.timeDetail
                                        .firstWhere((p0) => p0.time == time,
                                            orElse: () => TimeDetail(time: 0))
                                        .time ==
                                    0) {
                                  controller.timeDetail.add(
                                      TimeDetail(time: time, status: 'active'));
                                } else {
                                  controller.timeDetail
                                      .removeWhere((t) => t.time == time);
                                }
                              },
                              child: Obx(() => Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: controller.timeDetail
                                                  .firstWhere(
                                                      (p0) => p0.time == time,
                                                      orElse: () =>
                                                          TimeDetail(time: 0))
                                                  .time !=
                                              0
                                          ? primary
                                          : Colors.white),
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: controller.timeDetail
                                                        .firstWhere(
                                                            (p0) =>
                                                                p0.time == time,
                                                            orElse: () =>
                                                                TimeDetail(
                                                                    time: 0))
                                                        .time !=
                                                    0
                                                ? Colors.white
                                                : primary),
                                  ))));
                        } else {
                          return const SizedBox();
                        }
                      })
                    ])),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
