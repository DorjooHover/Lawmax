import 'package:flutter/material.dart';

import 'package:lawmax/global/global.dart';

class CardContainer extends StatelessWidget {
  const CardContainer(
      {super.key,
      this.child,
      this.title,
      this.value,
      this.borderRadius = origin});
  final Widget? child;
  final double borderRadius;
  final Widget? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title!,
              space16,
              Text(
                value!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
    );
  }
}
