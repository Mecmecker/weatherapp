

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

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
      center: Alignment(1, -0.8), // near the top right
      radius: 2,
      colors: <Color>[
        Color.fromARGB(180, 66, 108, 245), // blue sky
        Color.fromARGB(180, 58, 250, 253), // blue sky
        Color.fromARGB(180, 221, 138, 4), // blue sky
        Color.fromARGB(180, 219, 161, 68), // yellow sun
      ],
      stops: <double>[0, 0.4, 0.6, 1.0],
    );

    final Paint sun = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

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
        Offset(size.width * 1 / 10, size.height * 11 / 12), 160, sun);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
