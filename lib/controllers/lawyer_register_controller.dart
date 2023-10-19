import 'dart:async';


import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/provider/providers.dart';
import 'package:lawmax/routes.dart';


class LawyerRegisterController extends GetxController {
  final ApiRepository _apiRepository = ApiRepository();
  final homeController = Get.put(HomeController());
  final primeController = Get.put(PrimeController());

  // permission
  final personal = false.obs;
  final education = false.obs;
  final license = false.obs;
  final services = false.obs;
  final decided = false.obs;
  final account = false.obs;
  final addition = false.obs;
  final work = false.obs;
  final office = false.obs;
  // focus
  final nodeFirstName = FocusNode();
  //addition register
  final lawyer = Rxn(User(
      workLocation: LocationDto(lat: 0.0, lng: 0.0),
      officeLocation: LocationDto(lat: 0.0, lng: 0.0)));
  // personal
  final lawyerSymbols = "${registerSymbols[0]}${registerSymbols[0]}".obs;
  // education
  final graduate = <Education>[].obs;
  final degree = ''.obs;

  // service
  final service = <String>[''].obs;
  // decided
  final decidedCase = <Experiences>[].obs;

  // addition
  final phones = <String>[].obs;

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

  lawyerRequest() async {
    try {
      loading.value = true;
      lawyer.value?.phone = homeController.user?.phone;
      lawyer.value?.registerNumber =
          lawyerSymbols.value + lawyer.value!.registerNumber!;
      lawyer.value?.userServices = service;
      lawyer.value?.education = graduate;
      lawyer.value?.degree = degree.value;
      lawyer.value?.experiences = decidedCase;
      lawyer.value?.phoneNumbers = phones;
      final res = await _apiRepository.updateLawyer(lawyer.value!);
      res.fold((l) => null, (r) {
        if(r) {
          util.mainSnackbar("Success", SnackbarType.success);
          util.logout();
        } else {

          util.mainSnackbar("Error", SnackbarType.error);
          Get.toNamed(Routes.prime);
        }
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
      if (homeController.user?.degree != null &&
          homeController.user!.degree!.isNotEmpty) {
        degree.value = homeController.user!.degree!;
      } else {
        degree.value = '';
      }
      if (homeController.user?.education != null &&
          homeController.user!.education!.isNotEmpty) {
        graduate.value = homeController.user!.education!;
      } else {
        graduate.value = [Education(title: '')];
      }
      if (homeController.user?.experiences != null &&
          homeController.user!.experiences!.isNotEmpty) {
        decidedCase.value = homeController.user!.experiences!;
      } else {
        decidedCase.value = [
          Experiences(
              title: '', date: DateTime.now().millisecondsSinceEpoch, link: '')
        ];
      }

      if (homeController.user?.account == null) {
        lawyer.value?.account =
            Account(bank: '', username: '', accountNumber: 0);
      }

      if (homeController.user?.phoneNumbers != null &&
          homeController.user!.phoneNumbers!.isNotEmpty) {
        phones.value = homeController.user!.phoneNumbers!;
      } else {
        phones.value = [''];
      }
      if (homeController.user?.userServices != null &&
          homeController.user!.userServices!.isNotEmpty) {
        service.value = homeController.user!.userServices!;
      } else {
        service.value = [''];
      }

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
