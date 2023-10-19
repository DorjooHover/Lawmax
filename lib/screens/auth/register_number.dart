import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/auth_controller.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';


class RegisterNumberView extends StatelessWidget {
  RegisterNumberView({Key? key}) : super(key: key);
  final  controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimeAppBar(
            onTap: () {
          Get.toNamed(Routes.register);
            },
            title: 'Бүртгүүлэх'),
        backgroundColor: bg,
        body: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: origin,
              right: origin),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space32,
                  Text(
                    'Регистрийн дугаараа оруулна уу',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  space32,
                  Row(
                    children: [
                      Expanded(
                          child: Obx(() => DropdownLabel(
                              value: controller.registerSymbol1.value,
                              onChange: (String? v) {
                                controller.registerSymbol1.value = v as String;
                              },
                              list: registerSymbols))),
                      space8,
                      Expanded(
                          child: Obx(() => DropdownLabel(
                              value: controller.registerSymbol2.value,
                              onChange: (String? v) {
                                controller.registerSymbol2.value = v as String;
                              },
                              list: registerSymbols))),
                      space8,
                      Expanded(
                        flex: 4,
                        child: Input(
                            onChange: (p0) {
                              controller.registerNumber.value = p0;
                            },
                            textInputType: TextInputType.number,
                            labelText: 'Регитрийн дугаар'),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                  left: 0,
                  right: 0,
                  child: Obx(() => MainButton(
                        onPressed: () {
                          Get.toNamed(Routes.registerPhone);
                        },
                        disabled: controller.registerNumber.value == "",
                        text: "Үргэлжлүүлэх",
                        child: const SizedBox(),
                      )))
            ],
          ),
        ));
  }
}
