// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Image.asset('assets/clouds_image.png'),
    );
  }
}
