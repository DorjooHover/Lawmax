import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/data/data.dart';

import 'package:lawmax/global/global.dart';
import 'package:lawmax/routes.dart';
import 'package:lawmax/screens/screens.dart';


class OrdersView extends StatefulWidget {
  const OrdersView({super.key, required this.isLawyer});
  final bool isLawyer;
  @override
  State<OrdersView> createState() => _OrdersViewState();
}

final controller = Get.put(PrimeController());

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    controller.getOrderList(widget.isLawyer, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.getOrderList(widget.isLawyer, context);
        },
        child: Container(
            padding: const EdgeInsets.only(
                bottom: large, right: origin, left: origin),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
            
                
              children: controller.orders.map((e) {
                return Container(
                    margin: const EdgeInsets.only(bottom: origin),
                    child: OrderDetailView(
                        onTap: () async {
                          if (e.serviceType == 'online' ||
                              e.serviceType == 'onlineEmergency') {
                            homeController.getChannelToken(
                                e, widget.isLawyer, '');
                          } else {
                            homeController.loading.value = true;
                            if (e.serviceType == 'fulfilled') {
                              Get.to(() => OrderTrackingPage(location: e.location ??
                                      LocationDto(lat: 0.0, lng: 0.0),));
                            } else {
                              Get.to(() => UserOrderMapPageView(
                                      lawyerId: e.lawyerId!.sId!,
                                      location: e.location ??
                                          LocationDto(
                                              lat: 0.0, lng: 0.0)));
                            }
                            homeController.loading.value = false;
                          }
                        },
                        date: DateFormat('yyyy/MM/dd').format(
                            DateTime.fromMillisecondsSinceEpoch(e.date!)),
                        time: DateFormat('hh:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(e.date!)),
                        type: e.serviceType!,
                        name: widget.isLawyer
                            ? e.clientId?.lastName ?? ""
                            : e.lawyerId?.lastName ?? "",
                        image: !widget.isLawyer
                            ? e.lawyerId?.profileImg ?? ""
                            : "",
                        status: e.serviceStatus ?? "",
                        profession:
                            widget.isLawyer ? 'Үйлчлүүлэгч' : "Хуульч"));
              }).toList(),
                
              ),
            )),
      ),
    );
  }
}
