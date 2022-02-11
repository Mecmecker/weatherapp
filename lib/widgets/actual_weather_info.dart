import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/widgets/widgets.dart';

class ActualWeatherWidgetsInfo extends StatelessWidget {
  const ActualWeatherWidgetsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: const [
          MiniInfoCard(
            text: 'Viento',
            icon: FontAwesomeIcons.wind,
            unidades: 'm/s',
          ),
          MiniInfoCard(
              text: 'Sensación termica',
              icon: FontAwesomeIcons.thermometerEmpty,
              unidades: 'ºC'),
          MiniInfoCard(
              text: 'Presión', icon: FontAwesomeIcons.compass, unidades: 'hPa'),
          MiniInfoCard(
              text: 'Visibilidad',
              icon: FontAwesomeIcons.lowVision,
              unidades: 'Km'),
          MiniInfoCard(
              text: 'Temperatura',
              icon: FontAwesomeIcons.temperatureHigh,
              unidades: 'ºC'),
          // si hay info de lluvia o nieve se añadira if()
        ],
      ),
    );
  }
}
