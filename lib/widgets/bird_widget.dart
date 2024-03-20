// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdYAxis;
  static const double birdXAxis = -0.5;
  MyBird({required this.birdYAxis});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.blue,
      duration: Duration(),
      alignment: Alignment(birdXAxis, birdYAxis),
      child: Container(
        height: 60,
        width: 60,
        child: Image.asset('assets/flappy_bird_image.png'),
      ),
    );
  }
}
