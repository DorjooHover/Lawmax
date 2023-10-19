import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/controllers/controllers.dart';

import 'package:lawmax/global/global.dart';

const double kToolbarHeight = 76.0;

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({
    super.key,
    required this.currentIndex,
    this.titleMargin = 0.0,
    this.hasLeading = true,
    this.calendar = false,
    this.paddingBottom = 12.0,
    this.wallet = false,
    this.settingTap,
    this.calendarTap,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.settings = false,
  });
  final int currentIndex;
  final bool hasLeading;
  final bool settings;
  final double paddingBottom;
  final bool calendar;
  final Function()? settingTap;
  final Function()? calendarTap;
  final bool wallet;
  final double titleMargin;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  List<String> lawyerTitles = ['Нүүр', 'Захиалгууд', 'Профайл', ''];
  List<String> titles = ['Нүүр', 'Яаралтай', "Захиалгууд", "Профайл"];
  @override
  Widget build(BuildContext context) {
    final storage =GetStorage();
    final controller = Get.put(HomeController());
   
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + origin),
      padding: const EdgeInsets.symmetric(horizontal: origin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => controller.currentUserType.value == UserTypes.lawyer ||
                      controller.currentUserType.value== UserTypes.our
                  ? Text(
                      lawyerTitles[controller.currentIndex.value],
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  : Text(
                      titles[controller.currentIndex.value],
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              Row(
                children: [
                  settings
                      ? IconButton(
                          onPressed: settingTap,
                          icon: SvgPicture.asset(iconSettings))
                      : const SizedBox(),
                  calendar
                      ? IconButton(
                          onPressed: calendarTap,
                          icon: SvgPicture.asset(iconCalendar))
                      : const SizedBox()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
