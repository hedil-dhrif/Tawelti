import 'package:flutter/material.dart';
import 'package:tawelti/widgets/listCuisine.dart';


class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
     this.label,
    this.padding,
    this.value,
     this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}