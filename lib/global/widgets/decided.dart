import 'package:flutter/material.dart';

import 'package:lawmax/global/global.dart';



class DecidedWidget extends StatelessWidget {
  const DecidedWidget(
      {super.key,
      required this.onTitle,
      required this.onLink,
      required this.onDate,
      required this.title,
      required this.link,
      required this.date});
  final Function(String?) onTitle;
  final Function(String?) onLink;
  final Function(int) onDate;
  final String title;
  final String link;
  final int date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
          onChange: onTitle,
          value: title,
          labelText: 'Гарчиг',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Та гарчигаа оруулна уу';
            }

            return null;
          },
        ),
        space16,
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime.now());

            if (picked != null) {
              onDate(picked.millisecondsSinceEpoch);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: gray)),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                'Огноо: ${DateTime.fromMillisecondsSinceEpoch(date).year}-${DateTime.fromMillisecondsSinceEpoch(date).month < 10 ? 0 : ''}${DateTime.fromMillisecondsSinceEpoch(date).month}-${DateTime.fromMillisecondsSinceEpoch(date).day < 10 ? 0 : ''}${DateTime.fromMillisecondsSinceEpoch(date).day}',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: gray),
              )),
        ),
        space16,
        Input(
          autoFocus: false,
          onChange: onLink,
          labelText: 'Линк',
          value: link,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Та линкээ оруулна уу';
            }

            return null;
          },
        ),
      ],
    );
  }
}
