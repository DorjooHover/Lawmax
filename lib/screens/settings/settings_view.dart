import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
 
    return SafeArea(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: large),
        height: defaultHeight(context) + 80,
        color: bg,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: NetworkImage(
                            homeController.user?.profileImg != null &&
                                    homeController.user?.profileImg != ''
                                ? homeController.user!.profileImg!
                                : "https://images.unsplash.com/photo-1605664041952-4a2855d9363b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                          ),
                          fit: BoxFit.cover)),
                ),
                space16,
                Text(
                  '${homeController.user?.firstName ?? ""} ${homeController.user?.lastName ?? ''}',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            space32,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(origin),
                      ),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: const Icon(
                          Icons.phone_forwarded_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Утасны дугаар солих',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                space8,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (homeController.currentUserType.value != UserTypes.user ) {
                           homeController.currentUserType.value = homeController.user!.userType!;
                        
                        homeController.currentIndex.value = 0;
                      } else {
                       Get.toNamed(Routes.lawyerPersonal);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(origin),
                      ),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: SvgPicture.asset(iconRefresh),
                        title: Obx(
                          () => homeController.currentUserType.value != UserTypes.user
                              ? Text(
                                  'Хуульчийн цэс рүү буцах',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                )
                              : Text(
                                  'Хуульч болох',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            space8,
            space4,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(origin),
                      ),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: const  Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Холбоо барих',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                space8,
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const  EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(origin),
                      ),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: const Icon(
                          Icons.question_answer_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Түгээмэл асуулт хариулт',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            space8,
            space4,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      homeController.logout();   
                                       },
                    child: Container(
                      padding: const  EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(origin),
                      ),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Aпп-с гарах',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(origin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(origin), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: child,
          ),
          space16,
          const Expanded(
              child: Icon(
            Icons.arrow_forward_ios,
            color: gold,
          ))
        ],
      ),
    );
  }
}
