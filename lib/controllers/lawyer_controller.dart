import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/providers.dart';



class LawyerController extends GetxController {
  final ApiRepository _apiRepository = ApiRepository();
  final homeController = Get.put(HomeController());
  //addition register

  final CarouselController carouselController = CarouselController();
  final currentOrder = 0.obs;
  final availableTime = Rxn(Time(serviceType: []));
  final timeDetail = <TimeDetail>[].obs;
  final selectedDate = DateTime.now().obs;
  final selectedType = <TimeType>[].obs;
  final fade = true.obs;
  final loading = false.obs;
  Util util = Util();

  @override
  void onInit() async {
    Future.delayed(const Duration(milliseconds: 800), () {
      fade.value = false;
    });
    await start();
    super.onInit();
  }

  getOrderDetail(String id) async {
    try {
      Book? order;
      final res = await _apiRepository.getChannel(id);
      res.fold((l) => null, (r) => order = r);
      if(order != null) {
        return order;
      }
    }  catch (e) {
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  addAvailableDays() async {
    try {
      availableTime.value!.timeDetail = timeDetail;
      availableTime.value!.serviceType = selectedType;
      bool order = true;
      final  res = await _apiRepository.addAvailableDays(availableTime.value!);

        res.fold((l) => order = false, (r) {
          order = r;
        });
        return order;
      
    } catch (e) {
     util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  start() async {
    try {
      loading.value = true;

      await homeController.setupApp();
      // selectedAvailableDays.value = homeController.user?.availableDays ?? [];
      // selectedDate.value = DateTime.parse(
      //     homeController.user?.availableDays?.first.date ??
      // DateTime.now().toString());
      // selectedDay.value = homeController
      //         .user?.availableDays?.first.serviceTypeTime?.first.time ??
      //     [];
      // homeController.user?.availableDays?.first.serviceTypeTime?.first.time
      //     ?.map((e) => selectedTime.value =
      //         (e.time?.map((t) => SelectedTime(day: e.day, time: t)).toList() ??
      //             []));
      loading.value = false;
    } catch (e) {
      loading.value = false;
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  @override
  onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
