import 'package:flutter/material.dart';

// vertical line
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey.withOpacity(0.5);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 3, size.height / 2, 0, size.height); // Adjust control points
    path.quadraticBezierTo(-size.width / 3, size.height / 2, 0, 0); // Adjust control points

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

