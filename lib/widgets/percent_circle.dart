import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weatherapp/models/models.dart';

class PercentCircle extends StatelessWidget {
  final String text;
  final int valor;
  final CurrentWeather weather;
  const PercentCircle(
      {Key? key,
      required this.text,
      required this.weather,
      required this.valor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return CircularPercentIndicator(
      radius: 80,
      percent: valor / 100,
      animation: true,
      animationDuration: 5000,
      circularStrokeCap: CircularStrokeCap.round,
      lineWidth: 15,
      curve: Curves.easeInCirc,
      linearGradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 66, 157, 185),
          Color.fromARGB(255, 4, 96, 112),
        ],
      ),
      arcType: ArcType.FULL,
      arcBackgroundColor: const Color.fromARGB(255, 194, 226, 231),
      center: CircleAvatar(
        radius: 60,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$valor %',
                style: style.headline4,
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: style.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
