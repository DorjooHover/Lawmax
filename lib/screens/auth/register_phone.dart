import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/auth_controller.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';



class RegisterPhoneView extends StatelessWidget {
  const RegisterPhoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final controller = Get.put(AuthController());
  final phoneKey = GlobalKey<FormState>();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space32,
                  Text(
                    'Таны бүртгүүлсэн утасны дугаар таны аппликэйшнд Hэвтрэх нэр болохыг анхаарна уу',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  space32,
                  Form(
                    key: phoneKey,
                    child: Input(
                      autoFocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Та утасны дугаараа оруулна уу';
                        }
                        if (value.length != 8 &&
                            value.length > 4 &&
                            value.substring(0, 3) != '976') {
                          return 'Таны оруулсан утасны дугаар буруу байна';
                        }

                        return null;
                      },
                      onSubmitted: (p0) {
                        if (phoneKey.currentState!.validate()) {
                          Get.toNamed(Routes.registerPassword);
                        }
                        
                      },
                      value: controller.registerPhone.value,
                      textInputType: TextInputType.number,
                      labelText: 'Утасны дугаар',
                      onChange: (p0) => {controller.registerPhone.value = p0},
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                  left: 0,
                  right: 0,
                  child: Obx(() => MainButton(
                        onPressed: () {
                 Get.toNamed(Routes.registerPassword);
                        },
                        disabled: controller.registerPhone.value == "",
                        text: "Үргэлжлүүлэх",
                        child: const SizedBox(),
                      )))
            ],
          ),
        ));
  }
}
