import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lawmax/controllers/controllers.dart';
import 'package:lawmax/global/global.dart';


class WaitingChannelWidget extends StatelessWidget {
  const WaitingChannelWidget({super.key,});
  
  @override
  Widget build(BuildContext context) {
   final homeController = Get.put(HomeController());
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconWaiting,
                width: 87,
              ),
              space64,
              Text(
                '${homeController.currentUserType.value != UserTypes.user ? 'Хэрэглэгч' : 'Хуульч'} орж иртэл',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 24),
              ),
              Text(
                'Түр хүлээнэ үү',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 24),
              )
            ],
          )),
    );
  }
}
