import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/controllers/controllers.dart';

import 'package:lawmax/global/global.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar(
      {super.key, required this.changeIndex, required this.currentIndex});
  final void Function(int value) changeIndex;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
     
    final controller = Get.put(HomeController());
  
    return Obx(() => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (value) => changeIndex(value),
          destinations: controller.currentUserType.value== UserTypes.lawyer ||
                      controller.currentUserType.value== UserTypes.our
              ? lawyerNavbar.map((e) {
                  NavigationDestination body;
                  body = NavigationDestination(
                    icon: SvgPicture.asset(
                      e['icon']!,
                    ),
                    selectedIcon: SvgPicture.asset(e['activeIcon']!),
                    label: e['label']!,
                  );
                  // }

                  return body;
                }).toList()
              : userNavbar.map((e) {
                  NavigationDestination body;
                  body = NavigationDestination(
                    icon: SvgPicture.asset(e['icon']!),
                    selectedIcon: SvgPicture.asset(e['activeIcon']!),
                    label: e['label']!,
                  );
                  // }

                  return body;
                }).toList(),
        ));
  }
}
