import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/auth_controller.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'dart:developer' as dev;
final registerKey = GlobalKey<FormState>();

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
        appBar: PrimeAppBar(
            onTap: () {
              Navigator.pop(context);
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
              Form(
                onChanged: () {
                 dev.log("Object");
                },
                key: registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space32,
                    Text(
                      'Овог, нэрээ оруулна уу',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    space32,
                    Flexible(
                      child: Input(
                        autoFocus: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та овгоо оруулна уу';
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        labelText: 'Овог',
                        value: controller.firstName.value,
                        onChange: (p0) => {controller.firstName.value = p0},
                      ),
                    ),
                    space16,
                    Flexible(
                      child: Input(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та нэрээ оруулна уу';
                          }

                          return null;
                        },
                        labelText: 'Нэр',
                        value: controller.lastName.value,
                        onSubmitted: (p0) {
                          if (registerKey.currentState!.validate()) {
                            Get.toNamed(Routes.registerPhone); }
                        },
                        onChange: (p0) => {controller.lastName.value = p0},
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                  left: 0,
                  right: 0,
                  child: Obx(() => MainButton(
                        onPressed: () {
                    Get.toNamed(Routes.registerPhone);
                        },
                        disabled: controller.lastName.value == "" ||
                            controller.firstName.value == '',
                        text: "Үргэлжлүүлэх",
                        child: const SizedBox(),
                      )))
            ],
          ),
        ));
  }
}
