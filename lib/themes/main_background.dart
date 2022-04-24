import 'dart:math';

import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(225, 253, 207, 122),
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _BackgroundPainter()),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.8, -0.7), // near the top right
      radius: 0.5,
      colors: <Color>[
        Color.fromARGB(180, 221, 138, 4), // yellow sun
        Color.fromARGB(180, 221, 91, 4), // blue sky
      ],
      stops: <double>[0.4, 1.0],
    );

    const RadialGradient gradient2 = RadialGradient(
      center: Alignment(0.8, -0.7), // near the top right
      radius: 1,
      colors: <Color>[
        Color.fromARGB(180, 221, 138, 4), // blue sky
        Color.fromARGB(180, 219, 161, 68), // yellow sun
      ],
      stops: <double>[0.6, 1.0],
    );

    final Paint sun = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final Paint line = Paint()
      ..color = const Color.fromARGB(180, 221, 138, 4)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final Paint lineSlim = Paint()
      ..shader = gradient2.createShader(rect)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, lineSlim);

    canvas.drawCircle(
        Offset(size.width * 9 / 10, size.height * 1 / 8), 160, sun);

    for (double i = 90; i <= 270; i += 30) {
      var x1 = (size.width * 9 / 10) + 180 * cos(i * pi / 180);
      var y1 = (size.height * 1 / 8) + 180 * sin(i * pi / 180);

      var x2 = (size.width * 9 / 10) + 215 * cos(i * pi / 180);
      var y2 = (size.height * 1 / 8) + 215 * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
