import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';

final additionKey = GlobalKey<FormState>();

class AdditionWidget extends StatelessWidget {
  const AdditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    return Screen(
        step: 9,
        title: 'Нэмэлт мэдээлэл',
        children: Form(
          key: additionKey,
          child: Column(
            children: [
              space32,
              Text(
                'Өөрийн танилцуулгаа оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Obx(
                () => Column(
                    children: controller.phones.map((e) {
                  final i = controller.phones.indexOf(e);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: small),
                    child: Input(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Та утасны дугаараа оруулна уу';
                          }

                          return null;
                        },
                        value: controller.phones[i],
                        textInputAction: TextInputAction.next,
                        onChange: (p0) {
                          controller.phones[i] = p0;
                          check(controller);
                        },
                        textInputType: TextInputType.number,
                        labelText: 'Утасны дугаар'),
                  );
                }).toList()),
              ),
              space16,
              InputButton(
                  onPressed: () {
                    controller.phones.add('');
                  },
                  icon: Icons.abc,
                  text: 'Өөр утасны дугаар нэмэх'),
              space32,
              Input(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та цахим шуудангаа оруулна уу';
                    }

                    return null;
                  },
                  value: controller.lawyer.value?.email,
                  onChange: (p0) {
                    controller.lawyer.value?.email = p0;
                    check(controller);
                  },
                  onSubmitted: (p0) {
                    if (additionKey.currentState!.validate()) {
                      controller.lawyerRequest();
                    }
                  },
                  labelText: 'Цахим шуудан'),
              space32,
            ],
          ),
        ),
        child: Obx(() => MainButton(
              view: controller.addition.value,
              onPressed: () {
                controller.lawyerRequest();
              },
              disabled: !controller.addition.value,
              text: "Илгээх",
              child: const SizedBox(),
            )));
  }

  void check(LawyerRegisterController controller) {
    if (controller.lawyer.value?.email != '' && controller.phones.first != '') {
      controller.addition.value = true;
    } else {
      controller.addition.value = false;
    }
  }
}
