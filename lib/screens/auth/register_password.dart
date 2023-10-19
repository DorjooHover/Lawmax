import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/auth_controller.dart';
import 'package:lawmax/global/global.dart';

final passwordKey = GlobalKey<FormState>();

class RegisterPasswordView extends StatelessWidget {
  const RegisterPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final controller = Get.put(AuthController());
  final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
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
                key: passwordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space32,
                    Text(
                      '8 оронтой, том, жижиг үсэг, тоо орсон байх шаардлагатай',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    space32,
                    Obx(
                      () => Input(
                          autoFocus: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Та нууц үгээ оруулна уу';
                            }
                            if (!passwordRegex.hasMatch(value)) {
                              return 'Таны оруулсан нууц үг буруу байна';
                            }

                            return null;
                          },
                          onSubmitted: (p0) {
                            if (passwordKey.currentState!.validate()) {}
                          },
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                controller.registerPasswordIsVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.registerPasswordIsVisible.value =
                                    !controller.registerPasswordIsVisible.value;
                              }),
                          obscureText:
                              !controller.registerPasswordIsVisible.value,
                          labelText: 'Нууц үг',
                          tController: controller.registerPasswordController,
                          onChange: (p0) =>
                              {controller.registerPassword.value = p0}),
                    ),
                    space16,
                    Obx(
                      () => Input(
                          onSubmitted: (p0) {
                            if (passwordKey.currentState!.validate()) {
                              controller.register(context);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Та нууц үгээ давтан оруулна уу';
                            }
                            if (value != controller.registerPassword.value) {
                              return 'Таны оруулсан давтан нууц үг буруу байна';
                            }

                            return null;
                          },
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                controller.registerPasswordRepeatIsVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller
                                        .registerPasswordRepeatIsVisible.value =
                                    !controller
                                        .registerPasswordRepeatIsVisible.value;
                              }),
                          obscureText:
                              !controller.registerPasswordRepeatIsVisible.value,
                          labelText: 'Нууц үг дахин оруулах',
                          tController:
                              controller.registerPasswordRepeatController,
                          onChange: (p0) =>
                              {controller.registerPasswordRepeat.value = p0}),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => MainButton(
                      onPressed: () async {
                        await controller.register(context);
                      },
                      disabled: !passwordRegex
                              .hasMatch(controller.registerPassword.value) ||
                          controller.registerPasswordRepeat.value !=
                              controller.registerPassword.value,
                      text: "Бүртгүүлэх",
                      child: const SizedBox(),
                    ),
                  ))
            ],
          ),
        ));
  }
}
