import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class PrimeView extends GetView<PrimeController> {
  const PrimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrimeController());
    // final homeController = Get.put(HomeController());
    // final authController = Get.put(AuthController(apiRepository: Get.find()));
    // final oCcy = NumberFormat("₮ #,##0", "en_US");
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () async {
            await controller.start();
          },
          child: Container(
            color: bg,
            width: MediaQuery.of(context).size.width,
            height: defaultHeight(context),
            padding:
                const EdgeInsets.only(left: origin, top: origin, right: origin),
            child: SingleChildScrollView(
                child: Column(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: medium,
                    right: medium,
                    top: large,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    image: const DecorationImage(
                        image: NetworkImage(
                          'https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2019/05/joseph-barrientos-49318-unsplash-e1558728034701.jpg?resize=1500%2C1000&ssl=1',
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lawyer for personalized help ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      space8,
                      Text(
                        'Protect your family and your rights with expert legal help',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      space24,
                      TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 12)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16.5),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white)),
                          onPressed: () {
                           Get.toNamed(Routes.lawyerPersonal);
                          },
                          child: Text(
                            'Хуульч болох',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall,
                          ))
                    ],
                  ),
                ),
                space32,
                Text(
                  'Үйлчилгээ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                space16,
                Obx(
                  () => controller.loading.value
                      ? SizedBox(
                          height: 200,
                          child: Container(),
                        )
                      // ? SizedBox(
                      //     height: 200,
                      //     child: SkeletonListView(),
                      //   )
                      : GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: small,
                          shrinkWrap: true,
                          crossAxisSpacing: small,
                          children: controller.services
                              .map((s) => GestureDetector(
                                    onTap: () async {
                                      final res = await controller
                                          .getSubServices(s.sId!);
                                      if (res) {
                                        Get.toNamed(Routes.services, arguments: [s.title!, ServiceWidget(controller: controller) ]);
                                        
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                          color: rareWhite,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  origin)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration:
                                                    BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius
                                                          .circular(
                                                              origin),
                                                      topLeft: Radius
                                                          .circular(
                                                              origin)),
                                                  image:
                                                      DecorationImage(
                                                          image:
                                                              NetworkImage(
                                                            s.img != null &&
                                                                    s.img !=
                                                                        ''
                                                                ? s.img!
                                                                : 'https://images.unsplash.com/photo-1449157291145-7efd050a4d0e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                                          ),
                                                          fit: BoxFit
                                                              .cover),
                                                ),
                                              )),
                                          space6,
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              s.title ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                          ),
                                          space6,
                                          const Expanded(
                                              child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: line,
                                          ))
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()),
                ),
                space32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Хуульчид',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Row(
                          children:  [
                            Text(
                              'Бүгдийг харах',
                              style: TextStyle(
                                  color: gray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: gray,
                              size: 14,
                            )
                          ],
                        )),
                  ],
                ),
                space16,
                Flexible(
                    flex: 2,
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
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              itemCount: controller.lawyers.length,
                              itemBuilder: (context, index) =>
                                  GestureDetector(
                                onTap: () {
                                  controller.selectedLawyer.value =
                                      controller.lawyers[index];

                                  Get.toNamed(Routes.primeLawyer);
                                },
                                child: MainLawyer(
                                    user: controller.lawyers[index]),
                              ),
                            ),
                    )),
                space16
                  ],
                ),
                  ],
            )),
          )),
    );
  }
}


class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key, required this.controller});
  final PrimeController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
                                                          children: [
                                                            ListView
                                                                .builder(
                                                              itemCount: controller
                                                              .subServices
                                                              .length,
                                                              itemBuilder:
                                                              (context,
                                                                  index) {
                                                            return ListView.builder(
                                                                shrinkWrap: true,
                                                                itemCount: controller.subServices.length,
                                                                itemBuilder: (context, index) => GestureDetector(
                                                                      onTap: () {
                                                                        controller.selectedSubService.value = controller.subServices[index].sId!;
                                                                        controller.getSuggestLawyer(controller.subServices[index].title!, controller.subServices[index].description!, controller.subServices[index].sId!, context);
                                                                      },
                                                                      child: ServiceCard(text: controller.subServices[index].title ?? ''),
                                                                    ));
                                                              },
                                                            ),
                                                            Positioned(
                                                                bottom: MediaQuery.of(context)
                                                                    .padding
                                                                    .bottom ,
                                                                left:
                                                                    16,
                                                                right:
                                                                    16,
                                                                child:
                                                                    MainButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.bottomSheet(
                                                                        isScrollControlled: true,
                                                                        const OrderBottomSheet(
                                                                          title: 'Захиалгын төрөл сонгоно уу',
                                                                        ));
                                                                  },
                                                                  text:
                                                                      "Захиалга",
                                                                  child:
                                                                      const SizedBox(),
                                                                ))
                                                          ],
                                                        );
  }
}