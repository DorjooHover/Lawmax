
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';

import 'package:lawmax/global/global.dart';

class OrderTimeWidget extends StatelessWidget {
  const OrderTimeWidget({super.key, required this.day, required this.time});

  final int day;
  final List<int> time;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrimeController());
    Util util = Util();
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
                        color: controller.selectedDate.value
                                        .millisecondsSinceEpoch >=
                                    day &&
                                controller.selectedDate.value
                                        .millisecondsSinceEpoch <
                                    day + 1000 * 60 * 60 * 24
                            ? Colors.black
                            : Colors.white),
                    child: Column(
                      children: [
                        space4,
                        Obx(
                          () => Text(
                            util.getDay(DateTime.fromMillisecondsSinceEpoch(day)),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: controller.selectedDate.value
                                                    .millisecondsSinceEpoch >=
                                                day &&
                                            controller.selectedDate.value
                                                    .millisecondsSinceEpoch <
                                                day + 1000 * 60 * 60 * 24
                                        ? Colors.white
                                        : primary),
                          ),
                        ),
                        space8,
                        Obx(
                          () => Text(
                            '${DateTime.fromMillisecondsSinceEpoch(day).day}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: controller.selectedDate.value
                                                    .millisecondsSinceEpoch >=
                                                day &&
                                            controller.selectedDate.value
                                                    .millisecondsSinceEpoch <
                                                day + 1000 * 60 * 60 * 24
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
                  children: time.map((e) {
                    return GestureDetector(
                        onTap: () {
                          controller.selectedDate.value =
                              DateTime.fromMillisecondsSinceEpoch(e);
                              
                        },
                        child: Obx(() => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: controller.selectedDate.value
                                            .millisecondsSinceEpoch ==
                                        e
                                    ? primary
                                    : Colors.white),
                            child: Text(
                              '${DateTime.fromMillisecondsSinceEpoch(e).hour}:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: controller.selectedDate.value
                                                  .millisecondsSinceEpoch ==
                                              e
                                          ? Colors.white
                                          : primary),
                            ))));
                  }).toList())),
        ],
      ),
    );
  }
}
