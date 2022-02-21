import 'package:flutter/material.dart';
import 'package:weatherapp/models/models.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficasHorasScreen extends StatelessWidget {
  const GraficasHorasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HorasModel info =
        ModalRoute.of(context)!.settings.arguments as HorasModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(info.city.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(width: 3000, child: HourlyLinearChart(info: info)),
              ]),
            ),
            const SizedBox(height: 100),
            Container(width: double.infinity, height: 300, color: Colors.green),
            Container(
                width: double.infinity, height: 300, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}

class HourlyLinearChart extends StatelessWidget {
  final HorasModel info;
  const HourlyLinearChart({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contador = 1;
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.only(top: 12, right: 20, left: 12),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            leftTitles: SideTitles(showTitles: false),
            bottomTitles:
                SideTitles(margin: 10, reservedSize: 20, showTitles: true),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var valor in info.list) FlSpot(contador++, valor.main.temp)
              ],
              isCurved: true,
              barWidth: 5,
              colors: const [
                Color.fromARGB(255, 202, 7, 7),
              ],
              colorStops: [0, 48, 96],
              belowBarData: BarAreaData(
                show: true,
                colors: const [
                  Color.fromARGB(153, 248, 103, 19),
                  Color.fromARGB(153, 253, 95, 3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
