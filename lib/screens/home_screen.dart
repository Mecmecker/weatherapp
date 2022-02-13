import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    final weathers = weatherProvider.currentWeathers;

    return Scaffold(
      body: (weathers.isEmpty)
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: const Center(child: CircularProgressIndicator()))
          : PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _Pantalla(weather: weathers[index]);
              },
              itemCount: weathers.length,
              scrollDirection: Axis.horizontal,
            ),
    );
  }
}

class _Pantalla extends StatelessWidget {
  const _Pantalla({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(weather: weather),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              MaxMinDescription(weather: weather),
              const Divider(),
              const HorasInfoWidget(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PercentCircle(
                      text: 'Humedad',
                      weather: weather,
                      valor: weather.main.humidity),
                  PercentCircle(
                    text: 'Nubes',
                    weather: weather,
                    valor: weather.clouds.all,
                  ),
                ],
              ),
              const Divider(),
              ActualWeatherWidgetsInfo(weather: weather),
              const Divider(),
              const DiasInfoWidget(),
              const SizedBox(height: 80),
            ],
          ),
        )
      ],
    );
  }
}
