import 'package:flutter/material.dart';

class LegendPainter extends CustomPainter {
  final List<int> values;
  final String unit;
  final List<Color> colors;

  LegendPainter(this.values, this.unit, this.colors);
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
    final textSpan = TextSpan(
      text: unit,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width * 1 / 4,
    );

    const textStyle2 = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );
    final List<int> valores = values;
    final double lineLenght = size.width - ((1 / 6) + (1 / 15)) - 20;

    textPainter.paint(canvas, Offset(0, size.height * 2 / 7));
    canvas.drawLine(Offset(size.width * 1 / 6, size.height * 2 / 3),
        Offset(size.width * 14 / 15, size.height * 2 / 3), paint);
    int pos = 0;

    for (double i = 0; i < lineLenght; i += lineLenght / 6) {
      final textSpan = TextSpan(
        text: valores[pos].toString(),
        style: textStyle2,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: lineLenght * 1 / 5,
      );
      pos++;
      textPainter.paint(
          canvas, Offset(size.width * 1 / 7 + i, size.height * 2 / 7));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
