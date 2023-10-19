import 'package:flutter/material.dart';
import 'package:lawmax/global/constants/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splash',
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageLogo),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
            )
          ],
        ),
      ),
    );
  }
}
