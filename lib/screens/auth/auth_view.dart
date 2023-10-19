import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/constants/constants.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:lawmax/screens/screens.dart';


class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
   final loginKey = GlobalKey<FormState>();
  final AuthController controller = Get.find();
   @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: origin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16),
                      child: Image.asset(
                        imageLogo,
                        width: MediaQuery.of(context).size.width > 400
                            ? 200
                            : MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          Input(
                            textInputType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Та Утасны дугаараа оруулна уу';
                              }

                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            labelText: 'Утасны дугаар',
                            onChange: (p0) => {controller.phone.value = p0},
                          ),
                          space16,
                          Obx(
                            () => Input(
                                onSubmitted: (p0) {
                                  controller.login(context);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Та Утасны дугаараа оруулна уу';
                                  }

                                  return null;
                                },
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      !controller.isVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      controller.isVisible.value =
                                          !controller.isVisible.value;
                                    }),
                                obscureText: controller.isVisible.value,
                                labelText: 'Нууц үг',
                                tController: controller.loginPasswordController,
                                onChange: (p0) => {}),
                          ),
                          space16,
                          MainButton(
                            onPressed: () {},
                            borderColor: Colors.transparent,
                            color: Colors.transparent,
                            contentColor: primary,
                            text: 'Нууц үг мартсан',
                            child: const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    space16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MainButton(
                          onPressed: () async {
                            controller.login(context);
                          },
                          text: 'Нэвтрэх',
                          child: const SizedBox(),
                        ),
                        space16,
                        MainButton(
                          onPressed: () {
                            Get.toNamed(Routes.register);
                          },
                          color: Colors.transparent,
                          contentColor: primary,
                          text: 'Бүртгүүлэх',
                          child: const SizedBox(),
                        ),
                        space16,
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    ))
    ;
  
  }
}