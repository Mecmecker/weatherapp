import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/widgets/widgets.dart';

class ActualWeatherWidgetsInfo extends StatelessWidget {
  final OneCallResponse weather;
  const ActualWeatherWidgetsInfo({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          MiniInfoCard(
            text: 'Viento',
            icon: FontAwesomeIcons.wind,
            unidades: '${weather.current.windSpeed.round() * 3.6} Km/h',
          ),
          MiniInfoCard(
              text: 'Sensación termica',
              icon: FontAwesomeIcons.thermometerEmpty,
              unidades: '${weather.current.feelsLike.round()}ºC'),
          MiniInfoCard(
              text: 'Presión',
              icon: FontAwesomeIcons.compass,
              unidades: '${weather.current.pressure} hPa'),
          MiniInfoCard(
              text: 'Visibilidad',
              icon: FontAwesomeIcons.lowVision,
              unidades: '${weather.current.visibility / 1000} Km'),
          MiniInfoCard(
              text: 'Temperatura',
              icon: FontAwesomeIcons.temperatureHigh,
              unidades: '${weather.current.temp.round()}ºC'),
          // si hay info de lluvia o nieve se añadira if()
          if (weather.current.rain != null)
            const MiniInfoCard(
                text: 'Lluvia', icon: FontAwesomeIcons.water, unidades: 'mm'),
          if (weather.current.snow != null)
            const MiniInfoCard(
                text: 'Nieve',
                icon: FontAwesomeIcons.snowflake,
                unidades: 'mm'),
        ],
      ),
    );
  }
}
