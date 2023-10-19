import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

final accountKey = GlobalKey<FormState>();

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    return Screen(
        step: 8,
        resize: true,
        isScroll: false,
        title: 'Банкны мэдээлэл',
        children: Form(
          key: accountKey,
          child: Column(
            children: [
              space32,
              Text(
                'Цалин авах дансны мэдээллээ оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Input(
                  autoFocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та дансны дугаараа оруулна уу';
                    }

                    return null;
                  },
                  value: controller.lawyer.value?.account?.accountNumber != 0
                      ? controller.lawyer.value?.account?.accountNumber
                          .toString()
                      : '',
                  onChange: (p0) {
                    controller.lawyer.value?.account?.accountNumber =
                        int.parse(p0);
                    check(controller);
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  labelText: 'Дансны дугаар'),
              space32,
              Input(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та данс эзэмшигчийн нэрээ оруулна уу';
                    }

                    return null;
                  },
                  value: controller.lawyer.value?.account?.username,
                  onChange: (p0) {
                    controller.lawyer.value?.account?.username = p0;

                    check(controller);
                  },
                  textInputAction: TextInputAction.next,
                  labelText: 'Данс эзэмшигчийн нэр'),
              space32,
              Input(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та банкны нэрээ оруулна уу';
                    }

                    return null;
                  },
                  value: controller.lawyer.value?.account?.bank,
                  onChange: (p0) {
                    controller.lawyer.value?.account?.bank = p0;
                    check(controller);
                  },
                  labelText: 'Банкны нэр'),
              space32,
              Input(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та татвар төлөгчийн дугаараа оруулна уу';
                    }

                    return null;
                  },
                  onSubmitted: (p0) {
                    if (accountKey.currentState!.validate()) {
                     Get.toNamed(Routes.lawyerAddition);
                    }
                  },
                  value: controller.lawyer.value?.taxNumber,
                  onChange: (p0) {
                    controller.lawyer.value?.taxNumber = p0;
                    check(controller);
                  },
                  labelText: 'Татвар төлөгчийн дугаар'),
              space32,
            ],
          ),
        ),
        child: Obx(() => MainButton(
              view: controller.account.value,
              onPressed: () {
                Get.toNamed(Routes.lawyerAddition);
              },
              disabled: !controller.account.value,
              text: "Үргэлжлүүлэх",
              child: const SizedBox(),
            )));
  }

  void check(LawyerRegisterController controller) {
    if (controller.lawyer.value?.account?.accountNumber != null &&
        controller.lawyer.value?.account?.username != '' &&
        controller.lawyer.value?.taxNumber != null &&
        controller.lawyer.value?.account?.bank != '') {
      controller.account.value = true;
    } else {
      controller.account.value = false;
    }
  }
}
