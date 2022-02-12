import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/widgets/widgets.dart';

class ActualWeatherWidgetsInfo extends StatelessWidget {
  final CurrentWeather weather;
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
            unidades: '${weather.wind.speed.round() * 3.6} Km/h',
          ),
          MiniInfoCard(
              text: 'Sensación termica',
              icon: FontAwesomeIcons.thermometerEmpty,
              unidades: '${weather.main.feelsLike.round()}ºC'),
          MiniInfoCard(
              text: 'Presión',
              icon: FontAwesomeIcons.compass,
              unidades: '${weather.main.pressure} hPa'),
          MiniInfoCard(
              text: 'Visibilidad',
              icon: FontAwesomeIcons.lowVision,
              unidades: '${weather.visibility / 1000} Km'),
          MiniInfoCard(
              text: 'Temperatura',
              icon: FontAwesomeIcons.temperatureHigh,
              unidades: '${weather.main.temp.round()}ºC'),
          // si hay info de lluvia o nieve se añadira if()
        ],
      ),
    );
  }
}
