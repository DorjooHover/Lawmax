import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lawmax/global/global.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.expiredTime,
      required this.onTap,
      required this.price});
  final IconData icon;
  final String title;
  final int price;
  final int expiredTime;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("₮ #,##0", "en_US");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(origin),
      ),
      color: primary,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: primary,
        child: Container(
          padding: const EdgeInsets.all(origin),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 50,
                color: gold,
              ),
              space32,
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
              space32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Дуудлагын хөлс',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.white),
                      ),
                      space8,
                      Text(
                        '${oCcy.format(price)} төгрөг - $expiredTime мин',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  MainButton(
                      height: 36,
                      padding: const EdgeInsets.symmetric(
                          horizontal: small, vertical: small),
                      color: Colors.white,
                      contentColor: primary,
                      onPressed: onTap,
                      child: Icon(Icons.arrow_forward_ios))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
