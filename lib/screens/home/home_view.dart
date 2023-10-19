import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:lawmax/config/config.dart' as config;
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/screens/screens.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key, });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put<HomeController>(HomeController());
  final storage = GetStorage();
  Util util = Util();
  List<Widget> views = [
    const PrimeView(),
    const EmergencyHomeView(),
    const OrdersView(isLawyer: false),
    const SettingsView()
  ];
  List<Widget> lawyerViews = [
    const LawyerView(),
    const OrdersView(isLawyer: true),
    const SettingsView(),
    const SizedBox(),
  ];

  @override
  void initState() {
  
   
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => controller.obx(
          onLoading: const SplashView(),
          onError: (error) => Stack(
                children: [
                  const SplashView(),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Align(
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        borderOnForeground: true,
                        child: AnimatedContainer(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 400,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    "Check your internet connection and try again",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Obx(
                                  () => ElevatedButton(
                                    onPressed:
                                        controller.isLoading.value == true
                                            ? null
                                            : () => controller.setupApp(),
                                    child: const Text("Try again"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ), (user) {

        return Scaffold(
          appBar: MainAppBar(
            currentIndex: controller.currentIndex.value,
            settingTap: () async {},
            // calendarTap: () async {
            //   await primeController.getOrderList(false, context);
            // },
            settings: controller.currentIndex.value == 0,
            calendar: false,
          ),
          body: Obx(
            () => controller.currentUserType.value == UserTypes.user
                ? views[controller.currentIndex.value]
                : lawyerViews[controller.currentIndex.value],
          ),
          bottomNavigationBar: MainNavigationBar(
            currentIndex: controller.currentIndex.value,
            changeIndex: (value) {
              controller.currentIndex.value = value;
            },
          ),
        );
      }),
    );
  }
}

class InvalidConfigWidget extends StatelessWidget {
  /// Construct the [InvalidConfigWidget]
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text(
          'Make sure you set the correct appId, ${config.appId}, channelId, etc.. in the lib/config/agora.config.dart file.'),
    );
  }
}
