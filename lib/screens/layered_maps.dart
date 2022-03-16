import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LayeredMapsScreen extends StatefulWidget {
  const LayeredMapsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LayeredMapsScreen> createState() => _LayeredMapsScreenState();
}

class _LayeredMapsScreenState extends State<LayeredMapsScreen> {
  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider currentWeatherProvider =
        Provider.of<CurrentWeatherProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final LayerProvider layerProvider = Provider.of<LayerProvider>(context);
    final List<String> layers = ['TA2', 'PR0', 'WS10', 'CL', 'PA0'];
    final List<List<Color>> colors = colores;
    final List<String> units = ['   Cº', 'mm/h', 'm/s', '  %', 'mm'];
    final List<List<int>> values = valores;
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(),
      body: Stack(
        children: [
          CustomLayeredMap(
              currentWeatherProvider: currentWeatherProvider,
              layers: layers,
              layerProvider: layerProvider),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 1 / 18,
              width: size.width * 18 / 20,
              child: CustomPaint(
                  foregroundPainter: LegendPainter(
                      values[layerProvider.layerPos],
                      units[layerProvider.layerPos],
                      colors[layerProvider.layerPos])),
            ),
          )
        ],
      ),
    );
  }
}

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

List<List<Color>> colores = [
  const [
    Color(0xDD821692),
    Color(0xDD8257db),
    Color(0xDD208DEC),
    Color(0xDD23dddd),
    Color(0xDDc2ff28),
    Color(0xDDfff028),
    Color(0xDDffc228),
    Color(0xDDfc8014),
  ],
  const [
    Color(0xDDFEF9CA),
    Color(0xDDB9F7A8),
    Color(0xDD93F57D),
    Color(0xDD78F554),
    Color(0xDD50B033),
    Color(0xDD387F22),
    Color(0xDDF2A33A),
    Color(0xDDEB4726),
    Color(0xDD971D13),
  ],
  const [
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
    Color(0xEECECCFF),
    Color(0xEECECCFF),
    Color.fromARGB(179, 172, 100, 255),
    Color.fromARGB(179, 141, 100, 255),
    Color.fromARGB(80, 183, 0, 255),
    Color.fromARGB(70, 55, 1, 99),
    Color(0x0D1126FF),
  ],
  const [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(252, 252, 252, 250),
    Color.fromARGB(251, 241, 241, 230),
    Color(0xE9E9DFCC),
    Color.fromARGB(249, 209, 209, 208),
    Color.fromARGB(248, 189, 189, 184),
    Color.fromRGBO(172, 172, 171, 0.969),
    Color.fromARGB(210, 165, 165, 165),
    Color.fromARGB(246, 97, 97, 96),
  ],
  const [
    Color(0x00000000),
    Color(0xC8969600),
    Color(0x9696AA00),
    Color(0x7878BE19),
    Color(0x6E6ECD33),
    Color(0x5050E1B2),
    Color(0x1414FFE5),
  ],
];
List<List<int>> valores = [
  [-20, -10, 0, 10, 20, 30],
  [0, 10, 20, 30, 40, 50],
  [0, 20, 45, 65, 80, 100],
  [0, 20, 40, 60, 80, 100],
  [0, 10, 20, 30, 40, 50],
];
