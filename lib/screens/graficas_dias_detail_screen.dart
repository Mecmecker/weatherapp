import 'package:flutter/material.dart';

class GraficasDiasScreen extends StatelessWidget {
  const GraficasDiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _Background(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        children: [Text('Hola')],
                      ),
                    ),
                    itemCount: 4,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
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
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 89, 147, 175)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final Paint marco = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final Paint borde = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    final Paint sun = Paint()
      ..color = const Color.fromARGB(255, 221, 138, 4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 26,
    );
    const textSpan = TextSpan(
      text: 'Pronóstico 16 dias',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final Path path = Path();
    path.lineTo(0, size.height * 1 / 5);
    for (int i = 1; i < 8; i++) {
      path.quadraticBezierTo(size.width * i / 8, size.height * 3 / 13,
          size.width * i / 7, size.height * 1 / 5);
    }
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);

    final Path path2 = Path();
    path2.moveTo(size.width * 1 / 7, size.height * 1 / 11);
    path2.lineTo(size.width * 5 / 6, size.height * 1 / 11);
    path2.lineTo(size.width * 5 / 6, size.height * 1 / 6);
    path2.lineTo(size.width * 1 / 7, size.height * 1 / 6);
    path2.lineTo(size.width * 1 / 7, size.height * 2 / 23);

    canvas.drawPath(path2, borde);
    canvas.drawPath(path2, marco);
    canvas.drawPath(path, borde);

    canvas.drawCircle(
        Offset(size.width * 9 / 10, size.height * 5 / 8), 200, sun);

    textPainter.paint(canvas, Offset(size.width * 1 / 5, size.height * 1 / 9));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
