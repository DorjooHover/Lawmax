import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawmax/bindings/bindings.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/screens/screens.dart';

class Routes {
// routes
  static String splash = '/';

  // main

  static String home = '/home';
// prime
  static String prime = '/prime';
  static String primeLawyer = '$prime/lawyer';
  // auth
  static String auth = '/login';
  static String register = '/register';
  static String registerPhone = '$register/phone';
  static String registerPassword = '$register/password';

  // services
  static String voice = '/voice';
  static String video = '/video';
  static String subservice = '/subservice';
  static String services = '/services';

  // order
  static String order = '/order';
  static String orderTime = '$order/time';
  static String location = '$order/location';
  static String addition = '$order/addition';
  static String direction = '$order/direction';
  static String success = '$order/success';
  static String emergency= '/emergency';


  // lawyer
  static String lawyer = '/lawyer';
  static String lawyerPersonal = '$lawyer/personal';
  static String lawyerServiceType = '$lawyer/serviceType';
  static String lawyerSelectedService= '$lawyer/selectedService';
  static String lawyerAvailableDays = '$lawyer/availableDays';
  static String lawyerAddition = '$lawyer/addition';
  static String lawyerAccount = '$lawyer/account';
  static String lawyerLicense = '$lawyer/license';
  static String lawyerWork = '$lawyer/work';
  static String lawyerOffice = '$lawyer/office';
  static String lawyerService = '$lawyer/service';
  static String lawyerEducation = '$lawyer/education';
  static String lawyerCase = '$lawyer/case';


  // global
  static String alert = '/alert';
  static String waitingChannel= '/waitingChannel';
  static String tracker= '/tracker';
// pages
  static final pages = [
    // splash
    GetPage(
        name: splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    // home
    GetPage(
        name: home,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    //  auth
    GetPage(
        name: auth,
        page: () => const AuthView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    GetPage(
        name: register,
        page: () => const RegisterView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: registerPhone,
        page: () => const RegisterPhoneView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: registerPassword,
        page: () => const RegisterPasswordView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // audio
    GetPage(
        name: voice,
        page: () {
          Book order = Get.arguments;
          return AudioView(order: order);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: voice,
        page: () {
          Book order = Get.arguments;
          return VideoView(order: order);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: subservice,
        page: () {
          String title = Get.arguments[0];
          String description = Get.arguments[1];
          return SubServiceView(title: title, description: description);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: services,
        page: () {
          String title = Get.arguments[0];
          Widget children = Get.arguments[1];
          return ServicesView(title: title, children: children,);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    // order
    GetPage(
        name: orderTime,
        page: () => const OrderTimeView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: addition,
        page: () => const AdditionView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: emergency,
        page: () => const EmergencyHomeView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: direction,
        page: ()  {
          List<String> list = Get.arguments;
          return  DirectionView(list: list);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: success,
        page: ()  {
          String type = Get.arguments;
          return  SuccessView(type: type);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
        // prime
    GetPage(
        name: prime,
        page: () => const PrimeView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: primeLawyer,
        page: () => const OrderLawyerView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    // lawyer
    GetPage(
        name: lawyerServiceType,
        page: () => const LawyerServiceTypeView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerSelectedService,
        page: () => const LawyerSelectServiceView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerAvailableDays,
        page: () => const LawyerAvailableDays(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerAddition,
        page: () => const AdditionWidget(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerAccount,
        page: () => const AccountView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerLicense,
        page: () => const LicenseView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerWork,
        page: () => const WorkView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerOffice,
        page: () => const OfficeView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerService,
        page: () => const RegisterServiceView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerEducation,
        page: () => const EducationView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerCase,
        page: () => const CaseView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: lawyerPersonal,
        page: () => const PersonalView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    // GetPage(
    //     name: lawyerAvailableDay,
    //     page: () {
    //       int day = Get.arguments;
    //       return  LawyerAvailableDay(day: day);
    //     },
    //     transition: Transition.fade,
    //     transitionDuration: const Duration(milliseconds: 300)),

    
    // global
    GetPage(
        name: alert,
        page: () {
          String status = Get.arguments[0];
          String text = Get.arguments[1];
          return AlertView(status: status, text: text);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: waitingChannel,
        page: () => const WaitingChannelWidget(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: tracker,
        page: () {
          LocationDto location = Get.arguments;
          return OrderTrackingPage( location: location);
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
  ];
}
