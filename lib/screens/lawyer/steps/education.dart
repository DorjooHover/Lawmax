import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';
import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';

class EducationView extends StatefulWidget {
  const EducationView({super.key});

  @override
  State<EducationView> createState() => _EducationViewState();
}

final educationKey = GlobalKey<FormState>();

class _EducationViewState extends State<EducationView> {
  FocusNode schoolNode = FocusNode();

  bool school = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerRegisterController());
    List<String> degrees = ['0', 'Бакалавр', 'Магистр', 'Докторант'];

    return Screen(
        resize: true,
        step: 2,
        isScroll: false,
        title: 'Боловсрол',
        children: Form(
          key: educationKey,
          child: Column(
            children: [
              Text(
                'Та эрдмийн зэргийн талаарх мэдээллээ оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space32,
              Column(
                  children: degrees.map((e) {
                if (e != '0') {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: small),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.degree.value = e;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(origin),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: primary, width: 2),
                                ),
                                child: Obx(
                                  () => Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        color: controller.degree.value == e
                                            ? primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: primary, width: 2)),
                                  ),
                                )),
                          ),
                        ),
                        space8,
                        Flexible(
                          child: GestureDetector(
                            onTap: () => controller.degree.value = e,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: origin),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                e,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              }).toList()),
              space32,
              Text(
                'Та төгссөн сургуулийн талаарх мэдээллээ оруулна уу.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(
                () => Column(
                    children: controller.graduate.map((e) {
                  final i = controller.graduate.indexOf(e);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: small),
                    child: Input(
                        onChange: (p0) {
                          controller.graduate[i].title = p0;
                          if (p0.isNotEmpty) {
                            setState(() {
                              school = true;
                            });
                          } else {
                            setState(() {
                              school = false;
                            });
                          }
                          check(controller);
                        },
                        value: controller.graduate[i].title,
                        labelText: 'Төгссөн сургууль'),
                  );
                }).toList()),
              ),
              space16,
              Obx(() => controller.graduate.last.title != ''
                  ? InputButton(
                      onPressed: () {
                        controller.graduate.add(Education(title: ''));
                        setState(() {
                          school = false;
                        });
                      },
                      icon: Icons.abc,
                      text: 'Өөр сургууль нэмэх')
                  : const SizedBox()),
              space16,
              space64,
              space64,
            ],
          ),
        ),
        child: Obx(() => MainButton(
              onPressed: () {
                Get.toNamed(Routes.lawyerLicense);
              },
              view: school,
              disabled: !controller.education.value,
              text: "Үргэлжлүүлэх",
              child: const SizedBox(),
            )));
  }

  void check(LawyerRegisterController controller) {
    if (controller.degree.value != '' && controller.graduate[0].title != '') {
      controller.education.value = true;
    } else {
      controller.education.value = false;
    }
  }
}
