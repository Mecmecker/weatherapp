import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/models.dart';
import 'package:fl_chart/fl_chart.dart';

class Graficas extends StatelessWidget {
  final OneCallResponse weather;

  const Graficas({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          barGroups: weather.daily
              .map(
                (datos) => BarChartGroupData(
                  x: datos.dt,
                  barsSpace: -20,
                  barRods: [
                    BarChartRodData(
                      y: datos.temp.max,
                      width: 20,
                      gradientColorStops: [datos.temp.max, datos.temp.min, 0],
                      colors: const [
                        Color.fromARGB(255, 236, 97, 87),
                        Color.fromARGB(255, 243, 44, 30),
                      ],
                    ),
                    BarChartRodData(
                      y: datos.temp.min,
                      width: 20,
                      gradientColorStops: [datos.temp.max, datos.temp.min, 0],
                      colors: const [
                        Color.fromARGB(255, 2, 90, 112),
                        Color.fromARGB(255, 99, 180, 247),
                      ],
                    ),
                  ],
                ),
              )
              .toList(),
          titlesData: FlTitlesData(
            topTitles: SideTitles(showTitles: false),
            leftTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (double i) => DateFormat('EEEE')
                    .format(DateTime.fromMillisecondsSinceEpoch((weather.daily
                            .firstWhere((element) => element.dt == i.toInt())
                            .dt) *
                        1000))
                    .substring(0, 3)),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 4000),
      ),
    );
  }
}
