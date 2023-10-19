import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/routes.dart';

class RegisterServiceView extends StatefulWidget {
  const RegisterServiceView({super.key});

  @override
  State<RegisterServiceView> createState() => _RegisterServiceViewState();
}

final serviceKey = GlobalKey<FormState>();

class _RegisterServiceViewState extends State<RegisterServiceView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    final primeController = Get.put(PrimeController());
    List<String> services =
        primeController.services.map((e) => e.title!).toList();
    return Screen(
        step: 6,
        resize: true,
        title: 'Туршлага',
        children: Form(
          key: serviceKey,
          child: Column(
            children: [
              space32,
              Text(
                'Өөрийн туршлагаа оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Obx(() => Column(
                    children: controller.service.map((e) {
                      int i = controller.service.indexOf(e);
                 final val = primeController.services
                              .firstWhere((element) => element.sId == e,
                                  orElse: () => Service(title: ''))
                              .title ??
                          '';
                      if (val != '' || controller.service.length == 1) {
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: small),
                            child: DropdownLabel(
                                expanded: true,
                                value: val != '' ? val : services[0],
                                onChange: (String? v) {
                                   String id = primeController.services
                                        .firstWhere((s) => s.title == v)
                                        .sId ??
                                    primeController.services.first.sId!;
                                if (!controller.service.contains(id)) {
                                  if (controller.service.length == 1) {
                                    if (controller.service.first == '') {
                                      controller.service.add(id);
                                      controller.service.remove('');
                                    } else {
                                      controller.service.first = id;
                                    }
                                  } else {
                                    controller.service[i] = id;
                                  }
                                } else {
                                  Get.snackbar('Сонгогдсон байна', "");
                                }
                              },
                                list: services));
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                  )),
              space16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Text(
                      '${controller.service.length} / ${primeController.services.length}'))
                ],
              ),
              space16,
             Obx(() => controller.service.length < 4
                  ? InputButton(
                      onPressed: () {
                        controller.service
                            .add(primeController.services.first.sId!);
                      },
                      icon: Icons.abc,
                      text: 'Өөр чиглэл нэмэх')
                  : const SizedBox()),
              space16,
              Text(
                'Та ажилласан жилээ оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Input(
                  autoFocus: false,
                  onChange: (p0) {
                    controller.lawyer.value?.experience = int.parse(p0);
                    check(controller);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Та ажилсан жилээ оруулна уу';
                    }

                    return null;
                  },
                  onSubmitted: (p0) {
                    if (serviceKey.currentState!.validate()) {
                   Get.toNamed(Routes.lawyerCase);       }
                  },
                  textInputType: TextInputType.number,
                  labelText: 'Ажилласан жил'),
              space32,
              space64,
              space64,
            ],
          ),
        ),
        child: Obx(() => MainButton(
              onPressed: () {
             Get.toNamed(Routes.lawyerCase);          },
              disabled: !controller.services.value,
              text: "Үргэлжлүүлэх",
              child: const SizedBox(),
            )));
  }

  void check(LawyerRegisterController controller) {
    if (controller.service.isNotEmpty &&
        controller.lawyer.value?.experience != null) {
      controller.services.value = true;
    } else {
      controller.services.value = false;
    }
  }
}
