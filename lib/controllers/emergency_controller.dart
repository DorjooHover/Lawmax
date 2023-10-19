import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';


import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/providers.dart';
import 'package:lawmax/routes.dart';


class EmergencyController extends GetxController {
  final ApiRepository _apiRepository = ApiRepository();
  final homeController = Get.put(HomeController());
  //addition register
  final serviceType = "".obs;
  final reason = "".obs;
  final CarouselController carouselController = CarouselController();
  final currentOrder = 0.obs;
  final location = Rxn<LocationDto>(LocationDto(lng: 0, lat: 0));
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
      Book? book ;
      final res  = await _apiRepository.getChannel(id);
      res.fold((l) => null, (r) => book = r);
      if(book != null) {
        return book;
      }
    }  catch (e) {
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  Future<bool> sendOrder() async {
    try {
      loading.value = true;

      int price = 10000;
      int expiredTime = 10;

      if (serviceType.value == 'fulfilledEmergency') {
        final res = await _apiRepository.activeLawyer('any',
            serviceType.value, DateTime.now().millisecondsSinceEpoch, true);
            res.fold((l) => null, (r) async  {

  
       
        await _apiRepository.createEmergencyOrder(
            DateTime.now().millisecondsSinceEpoch,
            r.first.lawyer!,
            r.first.serviceType!
            .firstWhere((element) => element.type == serviceType.value)
            .expiredTime!,
            r.first.serviceType!
            .firstWhere((element) => element.type == serviceType.value)
            .price!,
            serviceType.value,
            reason.value,
            location.value!);
            });
      } else {
        homeController.createEmergencyOrder(
            "6454309e181b78295d2091b8",
            expiredTime,
            price,
            serviceType.value,
            reason.value,
            location.value!);
      }
      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;

      util.mainSnackbar(e.toString(), SnackbarType.error);
      return false;
    }
  }

  getChannelToken(Book order,String? profileImg) async {
    try {
      loading.value = true;
   
      final res = await _apiRepository.getChannel(order.sId!);
      res.fold((l) => null, (r) async {
        Get.to(() => WaitingChannelWidget());
        final   lRes = await _apiRepository.setChannel(
     
        order.sId!,
        r.channelName!,
      );
      lRes.fold((l) => null, (r) {
        if(r.serviceType == 'onlineEmergency') {
          Get.to(() => AudioView(order: r));
        }
      });
      });
     

     

      
      

      loading.value = false;
    } catch (e) {
      loading.value = false;
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  start() async {
    try {
      loading.value = true;

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
