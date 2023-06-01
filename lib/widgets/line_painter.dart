import 'package:flutter/cupertino.dart';

class LinePainter extends CustomPainter {
  final Color color;

  LinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final startX = 0.0;
    final startY = size.height / 2;
    final endX = size.width - 0.0;
    final endY = size.height / 2;

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}