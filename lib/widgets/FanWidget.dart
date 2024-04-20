import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FanIconWidget extends StatefulWidget {
  @override
  dynamic windSpeed = 0.0;
  FanIconWidget({required this.windSpeed});
  _FanIconWidgetState createState() => _FanIconWidgetState();
}

class _FanIconWidgetState extends State<FanIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller.repeat(); // Loop the animation continuously
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rotating Fan Icon
        RotationTransition(
          turns:
              Tween(begin: 0.0, end: double.parse(widget.windSpeed.toString()))
                  .animate(_controller),
          child: FaIcon(
            FontAwesomeIcons.fan,
            size: 25,
            color: Colors.blue[200],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
