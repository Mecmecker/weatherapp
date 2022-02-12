import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/widgets/widgets.dart';

import '../themes/themes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    final weathers = weatherProvider.currentWeathers;

    return Scaffold(
      body: (weathers.isEmpty)
          ? const CircularProgressIndicator()
          : CustomScrollView(
              slivers: [
                CustomAppBar(weather: weathers[0]),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _MaxMinDescription(weather: weathers[0]),
                      const Divider(),
                      const HorasInfoWidget(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PercentCircle(
                              text: 'Humedad',
                              weather: weathers[0],
                              valor: weathers[0].main.humidity),
                          PercentCircle(
                            text: 'Nubes',
                            weather: weathers[0],
                            valor: weathers[0].clouds.all,
                          ),
                        ],
                      ),
                      const Divider(),
                      ActualWeatherWidgetsInfo(weather: weathers[0]),
                      const Divider(),
                      const DiasInfoWidget(),
                      const SizedBox(height: 80),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class _MaxMinDescription extends StatelessWidget {
  final CurrentWeather weather;
  const _MaxMinDescription({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RichTextTemp(
                  style: style,
                  text: 'Max',
                  temp: weather.main.tempMax.round()),
              const SizedBox(width: 5),
              _RichTextTemp(
                  style: style,
                  text: 'Min',
                  temp: weather.main.tempMin.round()),
              const SizedBox(width: 30),
              Text(getCurrentDate(), style: style.headline5),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weather.weather[0].description, style: style.headline4),
            ],
          )
        ],
      ),
    );
  }
}

class _RichTextTemp extends StatelessWidget {
  final String text;
  final int temp;
  const _RichTextTemp({
    Key? key,
    required this.style,
    required this.text,
    required this.temp,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text, style: style.headline6),
          TextSpan(text: ' $temp ºC', style: style.headline4)
        ],
      ),
    );
  }
}
