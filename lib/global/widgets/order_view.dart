// import 'package:flutter/material.dart';
// import 'package:frontend/modules/prime/controllers/controllers.dart';
// import 'package:frontend/shared/index.dart';
// import 'package:get/get.dart';

// class OrderView extends GetView<PrimeController> {
//   const OrderView({
//     Key? key,
//     this.title = 'Цаг сонгох',
//   }) : super(key: key);
//   // final Function() onPressed;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PrimeController());
//     final times =
//         // controller.selectedLawyer.value?.userServices
//         //         ?.firstWhere(
//         //             (ser) => ser.serviceId == controller.selectedService.value)
//         //         .serviceTypes
//         //         ?.firstWhere((type) =>
//         //             type.serviceType ==
//         //             controller.selectedServiceType.value?.serviceType)
//         //         .time
//         //         ?.where((t) =>
//         //             (t.date ?? 0) >=
//         //             controller.selectedDate.value.millisecondsSinceEpoch) ??
//         [];
//     return Scaffold(
//         appBar: PrimeAppBar(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             title: title),
//         backgroundColor: bg,
//         body: Container(
//           padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top,
//               left: origin,
//               right: origin),
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   space32,
//                   Text(
//                     'Боломжит өдрүүд',
//                     textAlign: TextAlign.start,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   space32,
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           // if (controller.selectedDate.value.year >=
//                           //         DateTime.now().year &&
//                           //     controller.selectedDate.value.month >
//                           //         DateTime.now().month) {
//                           //   controller.selectedDate.value = DateTime(
//                           //       controller.selectedDate.value.year,
//                           //       controller.selectedDate.value.month - 1);
//                           // }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.only(
//                               top: small, bottom: small, left: 12, right: tiny),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: lightGray,
//                               borderRadius: BorderRadius.circular(large)),
//                           child: const Icon(
//                             Icons.arrow_back_ios,
//                             color: Colors.black,
//                             weight: 2,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                       space8,
//                       Obx(
//                         () => Text(
//                             // "${controller.selectedDate.value.month}-р сар",
//                             '',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(fontWeight: FontWeight.w600)),
//                       ),
//                       space8,
//                       GestureDetector(
//                         onTap: () {
//                           // controller.selectedDate.value = DateTime(
//                           //     controller.selectedDate.value.year,
//                           //     controller.selectedDate.value.month + 1);
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(small),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: lightGray,
//                               borderRadius: BorderRadius.circular(large)),
//                           child: const Icon(
//                             Icons.arrow_forward_ios,
//                             color: Colors.black,
//                             weight: 2,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Expanded(
//                   //   child: SingleChildScrollView(
//                   //       child: Obx(
//                   //     () => Column(
//                   //       children: List.generate(31, (e) {
//                   //         DateTime now = DateTime.now();
//                   //         DateTime selectedDay = DateTime(
//                   //             controller.selectedDate.value.year,
//                   //             controller.selectedDate.value.month + 1,
//                   //             0);
//                   //         int lastday = selectedDay.day;
//                   //         if (now.month ==
//                   //                 controller.selectedDate.value.month &&
//                   //             now.year == controller.selectedDate.value.year) {
//                   //           if (e + 1 >= now.day &&
//                   //               e + 1 <= lastday &&
//                   //               times.firstWhereOrNull((t) =>
//                   //                       DateTime.fromMillisecondsSinceEpoch(
//                   //                               t.date!)
//                   //                           .day ==
//                   //                       e + 1) !=
//                   //                   null) {
//                   //             final day =
//                   //                 getDay(DateTime(now.year, now.month, e));
//                   //             return AvailableDays(
//                   //               times: times
//                   //                       .firstWhereOrNull((t) =>
//                   //                           DateTime.fromMillisecondsSinceEpoch(
//                   //                                   t.date!)
//                   //                               .day ==
//                   //                           e + 1)
//                   //                       ?.time ??
//                   //                   [],
//                   //               controller: controller,
//                   //               day: day,
//                   //               dayNum: e + 1,
//                   //             );
//                   //           }
//                   //         } else {
//                   //           if (e + 1 <= lastday &&
//                   //               times.firstWhereOrNull((t) =>
//                   //                       DateTime.fromMillisecondsSinceEpoch(
//                   //                               t.date!)
//                   //                           .day ==
//                   //                       e + 1) !=
//                   //                   null) {
//                   //             final day = getDay(DateTime(
//                   //                 controller.selectedDate.value.year,
//                   //                 controller.selectedDate.value.month,
//                   //                 e));
//                   //             return GestureDetector(
//                   //               onTap: () {
//                   //                 // Get.to(() => LawyerAvailableDays());
//                   //               },
//                   //               // child: ServiceCard(text: e.title ?? ''),
//                   //               child: AvailableDays(
//                   //                 times: times
//                   //                         .firstWhereOrNull((t) =>
//                   //                             DateTime.fromMillisecondsSinceEpoch(
//                   //                                     t.date!)
//                   //                                 .day ==
//                   //                             e + 1)
//                   //                         ?.time ??
//                   //                     [],
//                   //                 controller: controller,
//                   //                 day: day,
//                   //                 dayNum: e + 1,
//                   //               ),
//                   //             );
//                   //           }
//                   //         }
//                   //         return SizedBox();
//                   //       }).toList(),
//                   //     ),
//                   //   )),
//                   // ),
//                   SizedBox(
//                     height: MediaQuery.of(context).padding.bottom + 106,
//                   ),
//                 ],
//               ),
//               Positioned(
//                   bottom: MediaQuery.of(context).padding.bottom + 50,
//                   left: 0,
//                   right: 0,
//                   child: MainButton(
//                     onPressed: () {
//                       controller.sendOrder(context);
//                     },
//                     text: "Илгээх",
//                     child: const SizedBox(),
//                   ))
//             ],
//           ),
//         ));
//   }
// }

// class AvailableDays extends StatelessWidget {
//   const AvailableDays(
//       {super.key,
//       required this.day,
//       required this.dayNum,
//       required this.times,
//       required this.controller});
//   final PrimeController controller;
//   final String day;
//   final int dayNum;
//   final List<String> times;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: origin),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//               child: Obx(() => Container(
//                     width: 66,
//                     height: 66,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: controller.selectedDay.value?.day ==
//                                 dayNum.toString()
//                             ? Colors.black
//                             : Colors.white),
//                     child: Column(
//                       children: [
//                         space4,
//                         Obx(
//                           () => Text(
//                             day,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .labelMedium!
//                                 .copyWith(
//                                     color: controller.selectedDay.value?.day ==
//                                             dayNum.toString()
//                                         ? Colors.white
//                                         : primary),
//                           ),
//                         ),
//                         space8,
//                         Obx(
//                           () => Text(
//                             '$dayNum',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     color: controller.selectedDay.value?.day ==
//                                             dayNum.toString()
//                                         ? Colors.white
//                                         : primary),
//                           ),
//                         ),
//                         space4
//                       ],
//                     ),
//                   ))),
//           space8,
//           Expanded(
//               flex: 4,
//               child: GridView.count(
//                   shrinkWrap: true,
//                   mainAxisSpacing: small,
//                   crossAxisSpacing: small,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 4,
//                   children: times.map((e) {
//                     return GestureDetector(
//                         // onTap: () {
//                         //   controller.selectedTime.value =
//                         //       SelectedTime(day: dayNum.toString(), time: e);

//                         //   controller.selectedDay.value = AvailableTime(
//                         //     date: DateTime.parse(
//                         //             "${DateFormat('yyyy-MM-dd').format(DateTime(
//                         //       controller.selectedDate.value.year,
//                         //       controller.selectedDate.value.month + 1,
//                         //       dayNum,
//                         //     ))}T$e")
//                         //         .toLocal()
//                         //         .millisecondsSinceEpoch,
//                         //     day: dayNum.toString(),
//                         //     time: [e],
//                         // );
//                         // },
//                         child: Obx(() => Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: controller.selectedTime.value?.day ==
//                                             dayNum.toString() &&
//                                         controller.selectedTime.value?.time == e
//                                     ? primary
//                                     : Colors.white),
//                             child: Obx(() => Text(
//                                   e,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(
//                                           color: controller.selectedTime.value
//                                                           ?.day ==
//                                                       dayNum.toString() &&
//                                                   controller.selectedTime.value
//                                                           ?.time ==
//                                                       e
//                                               ? Colors.white
//                                               : primary),
//                                 )))));
//                   }).toList())),
//         ],
//       ),
//     );
//   }
// }
