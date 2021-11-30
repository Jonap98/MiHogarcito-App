import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Color color;

  const Header({
    this.color = Colors.orangeAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPainter(color: color),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  final Color color;

  const _HeaderPainter({
    this.color = Colors.orangeAccent,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    lapiz.color = color;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = new Path();

    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.8, size.width, size.height * 0.4);

    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
