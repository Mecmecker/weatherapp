import 'package:flutter/material.dart';

class TitlePainter extends CustomPainter {
  final String title;

  TitlePainter(this.title);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const textStyle = TextStyle(
      color: Colors.black54,
      fontSize: 14,
    );
    final textSpan = TextSpan(
      text: title,
      style: textStyle,
    );
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width * 7 / 10,
    );

    textPainter.paint(
        canvas, Offset(size.width * 1 / 3 - title.length, size.height * 1 / 4));

    final deco = Path();
    deco.moveTo(size.width * 1 / 14, size.height * 7 / 8);
    deco.arcToPoint(Offset(size.width * 13 / 14, size.height * 7 / 8),
        radius: const Radius.circular(2000), clockwise: false);

    deco.moveTo(size.width * 13 / 14, size.height * 1 / 8);
    deco.arcToPoint(Offset(size.width * 1 / 14, size.height * 1 / 8),
        radius: const Radius.circular(2000), clockwise: false);

    canvas.drawPath(deco, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
