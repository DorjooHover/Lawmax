import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

final personalKey = GlobalKey<FormState>();

class PersonalView extends StatelessWidget {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    return Screen(
        step: 1,
        resize: false,
        title: 'Хувийн мэдээлэл',
        children: Form(
          key: personalKey,
          child: Column(
            children: [
              space32,
              Text(
                'Өөрийн танилцуулгаа оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Input(
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '') {
                      return 'Та овгоо оруулна уу';
                    }
                    return null;
                  },
                  autoFocus: true,
                  value: controller.lawyer.value?.firstName,
                  textInputAction: TextInputAction.next,
                  onChange: (p0) {
                    controller.lawyer.value?.firstName = p0;
                    checkPersonal(controller);
                  },
                  labelText: 'Овог'),
              space32,
              Input(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та нэрээ оруулна уу';
                    }
                    return null;
                  },
                  value: controller.lawyer.value?.lastName,
                  onChange: (p0) {
                    controller.lawyer.value?.lastName = p0;

                    checkPersonal(controller);
                  },
                  labelText: 'Нэр'),
              space32,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Obx(
                    () => DropdownLabel(
                        value: controller.lawyerSymbols.value.substring(0, 1),
                        onChange: (String? v) {
                          controller.lawyerSymbols.value = (v ??
                                  registerSymbols[0]) +
                              controller.lawyerSymbols.value.substring(1, 2);
                        },
                        list: registerSymbols),
                  )),
                  space8,
                  Flexible(
                    child: Obx(() => DropdownLabel(
                        value: controller.lawyerSymbols.value.substring(1, 2),
                        onChange: (String? v) {
                          controller.lawyerSymbols.value =
                              controller.lawyerSymbols.value.substring(0, 1) +
                                  (v ?? registerSymbols[0]);
                        },
                        list: registerSymbols)),
                  ),
                  space8,
                  Expanded(
                    flex: 4,
                    child: Input(
                        value: controller.lawyer.value?.registerNumber,
                        onSubmitted: (p0) {
                          if (personalKey.currentState!.validate()) {
                         Get.toNamed(Routes.lawyerEducation);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та регистрийн дугаараа оруулна уу';
                          }
                          if (value.length != 8) {
                            return 'Таны оруулсан регисртийн дугаар буруу байна';
                          }
                          return null;
                        },
                        onChange: (p0) {
                          controller.lawyer.value?.registerNumber = p0;
                          checkPersonal(controller);
                        },
                        textInputType: TextInputType.number,
                        labelText: 'Регистрийн дугаар'),
                  )
                ],
              )
            ],
          ),
        ),
        child: Obx(() => MainButton(
              onPressed: () {
                if (personalKey.currentState!.validate()) {
                Get.toNamed(Routes.lawyerEducation);
                }
              },
              disabled: !controller.personal.value,
              text: "Үргэлжлүүлэх",
              child: const SizedBox(),
            )));
  }

  void checkPersonal(LawyerRegisterController controller) {
    if (controller.lawyer.value?.registerNumber?.length == 8 &&
        controller.lawyer.value?.lastName != '' &&
        controller.lawyer.value?.firstName != '') {
      controller.personal.value = true;
    } else {
      controller.personal.value = false;
    }
  }
}
