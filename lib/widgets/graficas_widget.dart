import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/models.dart';
import 'package:fl_chart/fl_chart.dart';

class Graficas extends StatelessWidget {
  final OneCallResponse weather;

  const Graficas({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 250,
      child: BarChart(
        BarChartData(
            axisTitleData: FlAxisTitleData(
              topTitle: AxisTitle(
                  titleText: 'Temperaturas Diarias',
                  showTitle: true,
                  textAlign: TextAlign.start,
                  margin: 18,
                  textStyle: style.headline4),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: weather.daily
                .map(
                  (datos) => BarChartGroupData(
                    x: datos.dt,
                    barsSpace: -20,
                    showingTooltipIndicators: [0, 1],
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
            barTouchData: barTouchData),
        swapAnimationDuration: const Duration(milliseconds: 4000),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
}
