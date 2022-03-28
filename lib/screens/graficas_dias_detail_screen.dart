import 'package:flutter/material.dart';

import 'package:weatherapp/models/models.dart';

import '../widgets/widgets.dart';

class GraficasDiasScreen extends StatelessWidget {
  const GraficasDiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DiasWeatherModel info =
        ModalRoute.of(context)!.settings.arguments as DiasWeatherModel;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _Background(),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 1 / 4,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return FichaInfo(datos: info.list[index]);
                    },
                    itemCount: info.list.length,
                  ),
                ),
              ],
            ),
          )
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
      ..color = const Color.fromARGB(180, 221, 138, 4)
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
