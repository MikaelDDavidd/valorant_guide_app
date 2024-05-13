import 'package:flutter/material.dart';
import 'package:valorant_guide_app/app/modules/home/widgets/drawings/body_paint.dart';

class BodyWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const BodyWidget({super.key, required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(
          width,
          height,
        ),
        painter: BodyPaint(bodyColor: color),
      ),
    );
  }
}
