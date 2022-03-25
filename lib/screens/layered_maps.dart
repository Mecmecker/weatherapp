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
    final List<String> desc = [
      'Temperatura Actual',
      'Precipitaciones Actuales',
      'Velocidad Viento',
      'Porcentaje Nubes',
      'Lluvia acumulada'
    ];
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
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: size.height * 2 / 47,
                width: size.width * 14 / 20,
                child: CustomPaint(
                  foregroundPainter: TitlePainter(desc[layerProvider.layerPos]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
    Color.fromARGB(179, 200, 100, 255),
    Color.fromARGB(179, 183, 100, 255),
    Color.fromARGB(179, 172, 100, 255),
    Color.fromARGB(179, 141, 100, 255),
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
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
    Color(0xEECECCFF),
    Color(0xEECECCFF),
    Color(0xEECECCFF),
    Color.fromARGB(220, 100, 128, 255),
    Color.fromARGB(200, 100, 128, 255),
    Color.fromARGB(140, 100, 128, 255),
    Color.fromARGB(140, 100, 128, 255),
    Color.fromARGB(100, 100, 128, 255),
  ],
];
List<List<int>> valores = [
  [-20, -10, 0, 10, 20, 30],
  [0, 10, 20, 30, 40, 50],
  [0, 20, 45, 65, 80, 100],
  [0, 20, 40, 60, 80, 100],
  [0, 10, 20, 30, 40, 50],
];
