import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';

class ServicesView extends GetView<PrimeController> {
  const ServicesView({super.key, required this.title, required this.children});
  final String title;
  final Widget children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        appBar: PrimeAppBar(
          title: title,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: origin, horizontal: origin),
              height: defaultHeight(context) + 80,
              width: MediaQuery.of(context).size.width,
              child: children),
        ));
  }
}
