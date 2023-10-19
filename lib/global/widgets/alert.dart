import 'package:flutter/material.dart';

import 'package:lawmax/global/global.dart';

class AlertDialogView extends StatelessWidget {
  const AlertDialogView(
      {super.key,
      required this.icon,
      required this.title,
      required this.text,
      required this.approve,
      this.cancel,
      this.child,
      this.approveBtn = 'Тийм',
      this.cancelBtn = 'Буцах',
      required this.color});
  final IconData icon;
  final String title;
  final String text;
  final Color color;
  final Function() approve;
  final String approveBtn;
  final String cancelBtn;
  final Function()? cancel;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        Container(
          padding:
              const EdgeInsets.symmetric(vertical: large, horizontal: large),
          width: MediaQuery.of(context).size.width - large,
          child: Column(
            children: [
              Icon(
                icon,
                size: 90,
                color: color,
              ),
              space32,
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              space8,
              child ??
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
              space32,
              SizedBox(
                width: double.infinity,
                child: MainButton(
                  onPressed: approve,
                  text: approveBtn,
                  child: const SizedBox(),
                ),
              ),
              space8,
              SizedBox(
                width: double.infinity,
                child: MainButton(
                  color: Colors.transparent,
                  contentColor: primary,
                  onPressed: cancel ??
                      () {
                        Navigator.of(context).pop();
                      },
                  text: cancelBtn,
                  child: const SizedBox(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
