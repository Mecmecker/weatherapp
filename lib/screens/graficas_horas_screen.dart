import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/themes/themes.dart';

class GraficasHorasScreen extends StatelessWidget {
  const GraficasHorasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HorasModel info =
        ModalRoute.of(context)!.settings.arguments as HorasModel;
    final timezone = Provider.of<CurrentWeatherProvider>(context).timezone;
    final style = Theme.of(context).textTheme;
    const double _width = 3300;

    return Scaffold(
      appBar: AppBar(
        title: Text(info.city.name),
      ),
      body: Stack(
        children: [
          const NightBackground(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListIcons(info: info, timezone: timezone, style: style),
                    SizedBox(
                      width: _width,
                      child: HourlyLinearChart(
                        info: info,
                        interval: 7,
                        min: null,
                        titulo: 'Temperatura hora',
                        dato: 'temp',
                        colors: const [
                          Color.fromARGB(255, 202, 7, 7),
                          Color.fromARGB(153, 248, 103, 19),
                          Color.fromARGB(153, 253, 95, 3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: _width,
                      child: HourlyLinearChart(
                        info: info,
                        interval: 4,
                        min: null,
                        titulo: 'Sensación térmica',
                        dato: 'feelsLike',
                        colors: const [
                          Color.fromARGB(255, 5, 51, 1),
                          Color.fromARGB(153, 160, 236, 157),
                          Color.fromARGB(153, 100, 156, 74),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: _width,
                        child: HourlyLinearChart(
                            info: info,
                            interval: 20,
                            min: 0,
                            max: 100,
                            titulo: 'Humedad',
                            dato: 'humidity',
                            colors: const [
                              Color.fromARGB(255, 42, 20, 168),
                              Color.fromARGB(153, 19, 248, 248),
                              Color.fromARGB(153, 5, 103, 148),
                            ])),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: _width,
                        child: HourlyLinearChart(
                            info: info,
                            titulo: 'Presión',
                            dato: 'pressure',
                            interval: 10,
                            min: 1000,
                            colors: const [
                              Color.fromARGB(255, 125, 4, 141),
                              Color.fromARGB(153, 230, 129, 243),
                              Color.fromARGB(153, 138, 40, 141),
                            ])),
                    const SizedBox(height: 20),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListIcons extends StatelessWidget {
  const ListIcons({
    Key? key,
    required this.info,
    required this.timezone,
    required this.style,
  }) : super(key: key);

  final HorasModel info;
  final int timezone;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 3250,
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 3150 / 96,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color.fromARGB(255, 0, 13, 29),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(
                        'http://openweathermap.org/img/wn/${info.list[index].weather[0].icon}@2x.png'),
                  ),
                ),
                FittedBox(
                  child: Text(
                    DateFormat('h:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            (info.list[index].dt + timezone) * 1000)),
                    style: style.headline6,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: info.list.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 1),
      ),
    );
  }
}

class HourlyLinearChart extends StatelessWidget {
  final HorasModel info;
  final String dato, titulo;
  final List<Color> colors;
  final double interval;
  final double? min, max;
  const HourlyLinearChart({
    Key? key,
    required this.info,
    required this.dato,
    required this.colors,
    required this.titulo,
    this.interval = 2,
    this.min = 0,
    this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contador = 1;
    final style = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.only(top: 12, right: 20, left: 12),
      child: LineChart(
        LineChartData(
          minY: min,
          maxY: max,
          axisTitleData: FlAxisTitleData(
            topTitle: AxisTitle(
                titleText: titulo,
                showTitle: true,
                textAlign: TextAlign.start,
                margin: 18,
                textStyle: style.headline4),
          ),
          titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            leftTitles: SideTitles(
                showTitles: true, interval: interval, reservedSize: 28),
            bottomTitles:
                SideTitles(margin: 10, reservedSize: 20, showTitles: false),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              showingIndicators: [10],
              spots: [
                for (var valor in info.list)
                  FlSpot(contador++, valor.main.get(dato).toDouble())
              ],
              isCurved: true,
              barWidth: 5,
              colors: [
                colors[0],
              ],
              colorStops: [0, 48, 96],
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                spotsLine: BarAreaSpotsLine(
                  show: true,
                  applyCutOffY: true,
                  flLineStyle: FlLine(strokeWidth: 0.1),
                ),
                show: true,
                colors: [
                  colors[1],
                  colors[2],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
