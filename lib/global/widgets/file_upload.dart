import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';

class FileUploadView extends GetView<OrderController> {
  const FileUploadView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PrimeAppBar(
        title: 'Нэмэлт мэдээлэл',
        onTap: () => Navigator.of(context).pop(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: origin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const  EdgeInsets.only(top: large),
              child: Text(
                'Танд хавсаргах файл байгаа юу?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      onPressed: () {},
                      text: "Файл хавсаргах",
                      color: Colors.white,
                      contentColor: primary,
                      child:   const SizedBox(),
                    ),
                  ),
                  space16,
                  SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      onPressed: () {},
                      text: "Алгасах",
                      child: const SizedBox(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
