
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/global/global.dart';
import 'dart:developer' as dev;
import 'package:lawmax/provider/providers.dart';
import 'package:lawmax/routes.dart';


class AuthController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  Util util = Util();
  final storage = GetStorage();
  final loading = false.obs;
  final isVisible = true.obs;
  @override
  onInit() {
    super.onInit();
    loginPhoneController.addListener(_loginEmailListener);
  }
  // login
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final phone = "".obs;
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  // register
  final lastNameFocus = FocusNode();
  final firstNameFocus = FocusNode();
  final lastName = "".obs;
  final firstName = "".obs;

  final registerSymbol1 = registerSymbols[0].obs;
  final registerSymbol2 = registerSymbols[0].obs;
  final registerNumber = "".obs;

  final registerPhoneFocus = FocusNode();
  final registerPhone = "".obs;

  final registerPasswordFocus = FocusNode();
  final registerPasswordRepeatFocus = FocusNode();
  final registerPasswordIsVisible = false.obs;
  final registerPasswordRepeatIsVisible = false.obs;
  final registerPassword = "".obs;
  final registerPasswordRepeat = "".obs;
  final registerPasswordController = TextEditingController();
  final registerPasswordRepeatController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final pageController = PageController();
 
  showPassword() async {
    isVisible.value = !isVisible.value;
    await Future.delayed(const Duration(milliseconds: 500));
    isVisible.value = !isVisible.value;
  }

  

  _loginEmailListener() {
    if (loginPhoneController.text.length == 8) {
      Get.focusScope?.unfocus();
    }
  }

  register(BuildContext context) async {
    
 
      loading.value = true;

      final res = await apiRepository.register(registerPhone.value,
          registerPassword.value, firstName.value, lastName.value);
      res.fold((l) => null, (r) => util.saveToken(r));
      
      // Get.snackbar(
      //   'Бүртгэл амжилттай',
      //   " asdf",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: success,
      //   colorText: Colors.white,
      // );
      loading.value = false;
   
      // Get.snackbar(
      //   e.response?.statusMessage ?? 'Login Failed',
      //   e.response?.data['message'] ?? 'Something went wrong',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    
  }

  login(BuildContext context) async {
   

   
      loading.value = true;

      final res = await apiRepository.login(
        phone.value,
        loginPasswordController.text,
      );

      res.fold((l) => util.mainSnackbar(l, SnackbarType.error), (r) async {

       await storage.write(StorageKeys.token.name, r).then((value) => Get.toNamed(Routes.home));
        
      });
      loading.value = false;

      // print(e.response?.data['message'].toString());
      // Get.snackbar(
      //   e.response?.statusMessage ?? 'Login Failed',
      //   'Something went wrong',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      loginPasswordController.clear();
  
    
  }

  // forgetPassword(BuildContext context) async {
  //   AppFocus.unfocus(context);
  // }

  
  @override
  void dispose() {
    loginPasswordController.removeListener(_loginEmailListener);
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

}
