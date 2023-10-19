import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';

import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/provider.dart';
import 'package:lawmax/routes.dart';

class PrimeController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  final homeController = Get.put(HomeController());

  final fade = true.obs;
  Util util = Util();
  final order = Rxn(Book());
  final services = <Service>[].obs;
  final subServices = <SubService>[].obs;
  final lawyers = <User>[].obs;
  final times = <SortedTime>[SortedTime(day: 0, time: [])].obs;

  final loading = false.obs;
  final selectedService = "".obs;
  final selectedSubService = "".obs;

  final selectedExpiredTime = "".obs;
// order select date
  final selectedLawyer = Rxn<User?>();
  final selectedDate = DateTime.now().obs;
  final selectedLocation = Rxn<LocationDto>();

  // final selectedServiceType = Rxn<ServiceTypes>();
  // final lawyerPrice = <ServicePrice>[].obs;
  final selectedAvailableDays =
      AvailableDay(serviceId: "", serviceTypeTime: []).obs;
  final orders = <Book>[].obs;
  clearData() {
    // times.value = <SortedTime>[SortedTime(day: 0, time: [])].obs;
  }

  @override
  void onInit() async {
    await start();
    Future.delayed(const Duration(milliseconds: 800), () {
      fade.value = false;
    });
    super.onInit();
  }

  start() async {
    try {
      loading.value = true;
      final res = await apiRepository.servicesList();
      res.fold((l) => null, (r) => services.value = r);

      final lRes = await apiRepository.suggestedLawyers();
      lRes.fold((l) => null, (r) => lawyers.value = r);

      final ordersRes = await apiRepository.orderList();
      ordersRes.fold((l) => null, (r) => orders.value = r);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      // Get.snackbar(
      //   'Error',
      //   e.response?.data.toString() ?? 'Something went wrong',
      // );
    }
  }

  Future<bool> getTimeLawyer() async {
    try {
      loading.value = true;
      List<int> primaryTimes = [];

      final res =
          (await apiRepository.getTimeLawyer(selectedLawyer.value!.sId!));
      res.fold(
          (l) => util.mainSnackbar(
              "Таны сонгосон хуульч цаггүй байна.", SnackbarType.warning), (r) {
                
        if (r.timeDetail != null) {
          order.value?.serviceId ??= r.service;
          if (order.value?.serviceType == 'fulfilled') {
            order.value?.location = selectedLawyer.value!.officeLocation;
          }
          for (TimeDetail element in r.timeDetail!) {
            if (!primaryTimes.contains(element.time!) &&
                element.time! >
                    DateTime.now().millisecondsSinceEpoch - 1800000) {
              primaryTimes.add(element.time!);
            }
          }
        } else {
          util.mainSnackbar(
              "Таны сонгосон хуульч цаггүй байна.", SnackbarType.warning);
        }
      });
      primaryTimes.sort();

      for (int time in primaryTimes) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
        int day =
            DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
        // int nextDay = DateTime(date.year, date.month, date.day + 1)
        //     .millisecondsSinceEpoch;
        SortedTime sortedTime = times.firstWhere((t) => t.day == day,
            orElse: () => SortedTime(day: 0, time: []));
        if (sortedTime.day == 0) {
          sortedTime.day = day;
          sortedTime.time?.add(time);
        } else {
          sortedTime.time?.add(time);
        }

        if (times
                .firstWhere((element) => element.day == day,
                    orElse: () => SortedTime(day: 0, time: []))
                .day ==
            0) {
          times.add(sortedTime);
        }
      }
      loading.value = false;

      return true;
    } catch (e) {
      loading.value = false;

      util.mainSnackbar(
          "Таны сонгосон хуульч үнэ оруулаагүй байна", SnackbarType.warning);

      return false;
    }
  }

  Future<bool> getTimeService(String type) async {
    try {
      loading.value = true;
      List<int> primaryTimes = [];
      final res =
          await apiRepository.getTimeService(order.value!.serviceId!, type);
      res.fold((l) => null, (r) {
        for (var time in r) {
          for (var element in time.timeDetail!) {
            if (!primaryTimes.contains(element.time!) &&
                element.time! >
                    DateTime.now().millisecondsSinceEpoch - 1800000) {
              primaryTimes.add(element.time!);
            }
          }
        }
      });

      primaryTimes.sort();
      for (int time in primaryTimes) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
        int day =
            DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
        // int nextDay = DateTime(date.year, date.month, date.day + 1)
        //     .millisecondsSinceEpoch;
        SortedTime sortedTime = times.firstWhere((t) => t.day == day,
            orElse: () => SortedTime(day: 0, time: []));
        if (sortedTime.day == 0) {
          sortedTime.day = day;
          sortedTime.time?.add(time);
        } else {
          sortedTime.time?.add(time);
        }

        if (times
                .firstWhere((element) => element.day == day,
                    orElse: () => SortedTime(day: 0, time: []))
                .day ==
            0) {
          times.add(sortedTime);
        }
      }

      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      util.mainSnackbar('Цаг олдсонгүй.', SnackbarType.warning);
      return false;
    }
  }

  Future<bool> sendOrder() async {
    try {
      loading.value = true;
      String lawyerId = selectedLawyer.value?.sId ?? '';
      int price = 0;
      int expiredTime = 0;

      if (lawyerId == '') {

        final res = await apiRepository.activeLawyer(
            order.value!.serviceId!,
            order.value!.serviceType!,
            selectedDate.value.millisecondsSinceEpoch,
            false);
        res.fold((l) => null, (r) async {

 if (order.value?.serviceType == 'fulfilled') {
            order.value?.location =
                  lawyers.firstWhere((l) => l.sId == r.first.lawyer, orElse: () => lawyers[0]).officeLocation;

          }
          await apiRepository.createOrder(
              selectedDate.value.millisecondsSinceEpoch,
              r.first.lawyer!,
              r.first.serviceType!
                  .firstWhere(
                      (element) => element.type == order.value!.serviceType!)
                  .expiredTime!,
              r.first.serviceType!
                  .firstWhere(
                      (element) => element.type == order.value!.serviceType!)
                  .price!,
              order.value!.serviceType!,
              order.value!.serviceId!,
              selectedSubService.value,
              order.value?.location ?? LocationDto(lat: 0.0, lng: 0.0));
         
        });
      }
     else {
       await apiRepository.createOrder(
          selectedDate.value.millisecondsSinceEpoch,
          lawyerId,
          expiredTime,
          price,
          order.value!.serviceType!,
          order.value!.serviceId!,
          selectedSubService.value,
          order.value!.location ?? LocationDto(lat: 0.0, lng: 0.0));
      loading.value = false;
      times.value = <SortedTime>[SortedTime(day: 0, time: [])].obs;
     }
     loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      print(e);
     util.mainSnackbar('Error', SnackbarType.error);
     
      return false;
    }
  }

  getOrderList(bool isLawyer, BuildContext context) async {
    try {
      // loading.value = true;
      final res = await apiRepository.orderList();
      res.fold((l) => null, (r) => orders.value = r);


      // loading.value = false;
    } catch (e) {
      // loading.value = false;
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  getSuggestLawyer(String? title, String? description, String sId,
      BuildContext context) async {
    try {
      loading.value = true;
      
      Get.toNamed(Routes.subservice, arguments: [title, description]);
      selectedSubService.value = sId;
      final lRes = await apiRepository.suggestedLawyersByCategory(
          selectedService.value, sId);
          lRes.fold((l) => null, (r) => lawyers.value = r);


      loading.value = false;
    } on DioException {
      loading.value = false;
    }
  }

  Future<bool> getSubServices(String id) async {
    try {
      loading.value = true;
      order.value?.serviceId = id;
      final res = await apiRepository.subServiceList(id);
      res.fold((l) => null, (r) => subServices.value = r);
   

      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      util.mainSnackbar(e.toString(), SnackbarType.error);
     
      return false;
    }
  }

  @override
  onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
