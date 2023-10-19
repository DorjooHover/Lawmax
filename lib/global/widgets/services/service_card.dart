import 'package:flutter/material.dart';

import 'package:lawmax/global/global.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(origin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(origin), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Text(text, style: Theme.of(context).textTheme.displayMedium),
          ),
          space16,
          const Expanded(
              child: Icon(
            Icons.arrow_forward_ios,
            color: gold,
          ))
        ],
      ),
    );
  }
}
