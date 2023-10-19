import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lawmax/global/constants/constants.dart';

import 'package:lawmax/routes.dart';

import 'dart:developer' as dev;

class SplashController extends GetxController {

  late Worker worker;
  final storage = GetStorage();
 final token = Rxn<String?>();
  // final mainController = Get.put(MainController());
  @override
  void onInit() async {
    try {
      
      final isCurrent = await _isCurrentVersion();
      if (isCurrent == null) {
      } else {
        if (isCurrent) {
          _checkAuthStatus();
        } else {
          // _showUpdateDialog();
        }
      }
    } on Exception catch (e) {
      dev.log(e.toString());
    }
    super.onInit();
  }


  Future<bool?> _isCurrentVersion() async {
    try {
      return true;
    } on DioException {
      return null;
    } catch(e) {


      return null;
    }
  }

  /// CHECKING UPDATE VERSION

  _checkAuthStatus() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    
    worker = ever<String?>(
       token  ,
      (tkn) async {
        if (tkn != null) {
          // await storage.write(StorageKeys.currentPage.name, 0);
          Get.toNamed(Routes.home);
        } else {
          Get.toNamed(Routes.auth);
        }
      },
    );
    token.value = storage.read(StorageKeys.token.name);
    
  }
 

  @override
  void dispose() {
    worker.dispose();
    super.dispose();
  }
}
