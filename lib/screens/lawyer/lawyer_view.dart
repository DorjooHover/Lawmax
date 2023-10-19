import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:lawmax/screens/screens.dart';

class LawyerView extends GetView<LawyerController> {
  const LawyerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerController());
    final primeController = Get.put(PrimeController());
    final homeController = Get.put(HomeController());
    final oCcy = NumberFormat("₮ #,##0", "en_US");

    return SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await controller.start();
            },
            child: Container(
              color: bg,
              height: defaultHeight(context),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: origin, top: origin, right: origin),
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MainLawyer(
                      bg: Colors.white,
                      user: homeController.user ?? User(),
                    ),
                    space16,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(origin)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const  Text('Энэ сарын орлого'),
                                Text(
                                  oCcy.format(50000),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: success),
                                )
                              ],
                            ),
                          ),
                        ),
                        space8,
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(origin)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             const  Text('Энэ сарын орлого'),
                              Text(
                                '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: primary),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    space16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Захиалгууд',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            primeController.getOrderList(true, context);
                            homeController.currentIndex.value = 1;
                          },
                          child: Text(
                            "Бүх захиалгууд",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        )
                      ],
                    ),
                    space16,
                    Obx(
                      () => !primeController.loading.value
                          ? primeController.orders.isNotEmpty
                              ? SizedBox(
                                  height: 216,
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        carouselController:
                                            controller.carouselController,
                                        options: CarouselOptions(
                                            enableInfiniteScroll: false,
                                            height: 185.0,
                                            viewportFraction: 0.95,
                                            onPageChanged: (index, reason) =>
                                                controller.currentOrder.value =
                                                    index,
                                            padEnds: false),
                                        items: primeController.orders.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: small),
                                                child: OrderDetailView(
                                                    onTap: () {
                                                      if (i.serviceType ==
                                                             'online' ||
                                                          i.serviceType ==
                                                              'onlineEmergency') {
                                                        homeController
                                                            .getChannelToken(
                                                                i, true, '');
                                                      } else {
                                                        Get.toNamed(
                                                            Routes.tracker,
                                                            arguments: i
                                                                    .location ??
                                                                LocationDto(
                                                                    lat: 0.0,
                                                                    lng: 0.0));
                                                      }
                                                    },
                                                    date: DateFormat('yyyy/MM/dd')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                i.date!)),
                                                    time: DateFormat('hh:mm')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                i.date!)),
                                                    type: i.serviceType ??
                                                        '',
                                                    name:
                                                        i.clientId?.lastName ??
                                                            "",
                                                    image: '',
                                                    status:
                                                        i.serviceStatus ?? "",
                                                    profession: 'Үйлчлүүлэгч'),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            primeController.orders.map((e) {
                                          final i =
                                              primeController.orders.indexOf(e);
                                          return GestureDetector(
                                              onTap: () => controller
                                                  .carouselController
                                                  .animateToPage(i),
                                              child: Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller.currentOrder
                                                              .value ==
                                                          i
                                                      ? gold
                                                      : line,
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: line,
                                      borderRadius:
                                          BorderRadius.circular(origin)),
                                  alignment: Alignment.center,
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: secondary,
                                        size: 24,
                                      ),
                                      space16,
                                      Text(
                                        'Одоогоор захиалга байхгүй байна',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(color: secondary),
                                      ),
                                    ],
                                  ))
                          : SizedBox(
                              height: 200,
                              child: Container(),
                            ),
                          // : SizedBox(
                          //     height: 200,
                          //     child: SkeletonListView(),
                          //   ),
                    ),
                    homeController.user!.rating!.isNotEmpty
                        ? space32
                        : const SizedBox(),
                    homeController.user!.rating!.isNotEmpty
                        ? ClientRatingWidget(
                            ratings: homeController.user!.rating!)
                        : const SizedBox(),
                    space16,
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.lawyerSelectedService);
                          },
                          child: CardContainer(
                            value: 'Үйлчилгээний боломжит цаг тохируулах',
                            title: SvgPicture.asset(iconClock),
                          ),
                        )),
                        space16,
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            homeController.currentUserType.value = UserTypes.user;
                            Get.toNamed(Routes.home);
                          },
                          child: CardContainer(
                            value: 'Хэрэглэгч цэс рүү буцах',
                            title: SvgPicture.asset(iconRefresh),
                          ),
                        )),
                      ],
                    ),
                    space16
                  ],
                ),
              ])),
            )));
  }
}
