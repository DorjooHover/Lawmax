import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';

class OrderDetailView extends GetView<PrimeController> {
  const OrderDetailView(
      {super.key,
      required this.name,
      required this.profession,
      required this.status,
      required this.type,
      required this.onTap,
      required this.date,
      required this.image,
      required this.time});
  final String name;
  final String profession;
  final Function() onTap;
  final String status;
  final String type;
  final String date;
  final String time;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(origin), color: Colors.white),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              image != ""
                                  ? image
                                  : "https://images.unsplash.com/photo-1605664041952-4a2855d9363b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                            ),
                            fit: BoxFit.cover,
                          )),
                      child: const SizedBox()),
                  space16,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      space8,
                      Text(
                        profession,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      space8,
                      status == 'active'
                          ? Text(
                              "Таны цаг бэлэн боллоо.",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: success),
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialogView(
                                  icon: Icons.recycling,
                                  title: 'Захиалгын цаг өөрчлөх',
                                  text:
                                      'Та захиалгын цагийг өөрчлөхдөө итгэлтэй байна уу?',
                                  approve: () {},
                                  color: warning);
                            });
                      },
                      icon: const  Icon(Icons.recycling)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialogView(
                                  icon: Icons.delete,
                                  title: 'Захиалга цуцлах',
                                  text:
                                      'Та захиалгаа цуцлахдаа итгэлтэй байна уу?',
                                  approve: () {},
                                  color: error);
                            });
                      },
                      icon:const  Icon(Icons.delete))
                ],
              )
            ],
          ),
          space16,
          Row(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              space16,
              Text(
                time,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: primary),
              )
            ],
          ),
          space16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical:
                      type == 'onlineEmergency' || type == 'fulfilledEmergency'
                          ? small
                          : 0,
                  horizontal:
                      type == 'onlineEmergency' || type == 'fulfilledEmergency'
                          ? origin
                          : 0,
                ),
                decoration: BoxDecoration(
                    color: type == 'onlineEmergency' ||
                            type == 'fulfilledEmergency'
                        ? lightError.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: type == 'onlineEmergency' ||
                            type == 'fulfilledEmergency'
                        ? BorderRadius.circular(40)
                        : BorderRadius.zero),
                child: Row(
                  children: [
                    type == 'onlineEmergency' || type == 'fulfilledEmergency'
                        ? Container(
                            margin: const EdgeInsets.only(right: small),
                            child: const Icon(
                              Icons.error_outline,
                              color: error,
                            ))
                        : const SizedBox(),
                    Text(
                      type == 'online'
                          ? 'Онлайн уулзалт'
                          : type == 'onlineEmergency'
                              ? 'Яаралтай'
                              : type == 'fulfilled'
                                  ? 'Биечлэн уулзах'
                                  : type == 'fulfilledEmergency'
                                      ? 'Яаралтай'
                                      : '',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: type =='onlineEmergency' ||
                                  type == 'fulfilledEmergency'
                              ? error
                              : primary),
                    ),
                  ],
                ),
              ),
              Obx(() => MainButton(
                    loading: controller.loading.value,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                        vertical: small, horizontal: origin),
                    borderRadius: 40,
                    onPressed: onTap,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            type == 'onlineEmergency'
                                ? iconPhone
                                : type == 'online'
                                    ? iconCamera
                                    : iconLocation,
                            width: 13),
                        space8,
                        Text(
                          type == 'online' || type == 'onlineEmergency'
                              ? 'Дуудлага эхлүүлэх'
                              : 'Байршил харах',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
