// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TwoLineWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  // ignore: prefer_const_constructors_in_immutables
  TwoLineWidget({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        SizedBox(
          height: 18,
        ),
        Text(
          subTitle,
          style: TextStyle(color: Colors.white, fontSize: 38),
        ),
      ],
    );
  }
}
