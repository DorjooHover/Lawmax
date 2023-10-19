import 'package:flutter/material.dart';
import 'package:lawmax/global/global.dart';


class PrimeAppBar extends StatelessWidget implements PreferredSizeWidget {
  PrimeAppBar(
      {super.key,
      required this.title,
      this.titleMargin = 0.0,
      this.hasLeading = true,
      this.hasLogo = true,
      this.paddingBottom = 12.0,
      this.wallet = false,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.settings = false,
      this.bar = false,
      this.step = 0,
      required this.onTap});
  final String title;
  final bool hasLeading;
  final bool settings;
  final double paddingBottom;
  final bool hasLogo;
  final bool wallet;
  final bool bar;
  final int step;
  final double titleMargin;
  final MainAxisAlignment mainAxisAlignment;
  final Function() onTap;
  @override
  Size get preferredSize => Size.fromHeight(bar ? 82 : 80);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: origin),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: primary,
                    )),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                bar && step != 0
                    ? Container(
                        alignment: Alignment.center,
                        width: large,
                        child: Text(
                          '$step/9',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : const SizedBox(
                        width: huge,
                      )
              ],
            ),
            bar
                ? SizedBox(
                    width: double.infinity,
                    height: 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Container(
                          color: const Color(0xff979797),
                        )),
                        Positioned(
                          left: 0,
                          child: Container(
                            color: primary,
                            width: (MediaQuery.of(context).size.width - 32) *
                                step /
                                9,
                            height: 2,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ));
  }
}
