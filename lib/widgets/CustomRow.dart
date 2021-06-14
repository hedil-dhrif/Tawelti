import 'package:flutter/material.dart';


class CustomRow extends StatelessWidget {
  final String title1;
  final String title2;

  const CustomRow({
    this.title1,
    this.title2,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title1,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black38,
          ),
        ),
        Text(
          title2,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
