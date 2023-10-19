import 'package:flutter/material.dart';
import 'package:lawmax/global/global.dart';


class Screen extends StatelessWidget {
  const Screen(
      {Key? key,
      required this.title,
      required this.children,
      this.isScroll = true,
      this.resize = true,
      required this.step,
      required this.child})
      : super(
          key: key,
        );
  final String title;
  final Widget children;
  final Widget child;
  final bool isScroll;
  final bool resize;
  final int step;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: resize,
        appBar: PrimeAppBar(
            bar: true,
            step: step,
            onTap: () {
              Navigator.of(context).pop();
            },
            title: title),
        backgroundColor: bg,
        body: Container(
          padding: const EdgeInsets.only(left: origin, right: origin),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: isScroll ? const NeverScrollableScrollPhysics() : null,
                child: children,
              ),
              Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                  left: 0,
                  right: 0,
                  child: child)
            ],
          ),
        ));
  }
}
