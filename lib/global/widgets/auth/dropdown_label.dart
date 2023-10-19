import 'package:flutter/material.dart';
import 'package:lawmax/global/global.dart';

class DropdownLabel extends StatelessWidget {
  const DropdownLabel(
      {super.key,
      required this.value,
      required this.onChange,
      this.expanded = false,
      required this.list});
  final String value;
  final bool expanded;
  final Function(String?) onChange;
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(small),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: line, width: 1)),
      child: DropdownButton(
        isExpanded: true,
        value: value,
        alignment: AlignmentDirectional.center,
        iconSize: 0,
        icon:
            const Visibility(visible: false, child: Icon(Icons.arrow_downward)),
        style: Theme.of(context).textTheme.displaySmall,
        underline: Container(
          height: 0,
        ),
        onChanged: onChange,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
