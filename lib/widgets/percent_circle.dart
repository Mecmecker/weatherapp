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
    return CircularPercentIndicator(
      radius: 80,
      percent: valor / 100,
      animation: true,
      animationDuration: 1500,
      lineWidth: 15,
      arcType: ArcType.FULL,
      arcBackgroundColor: Colors.red.shade100,
      center: CircleAvatar(
        radius: 60,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$valor %',
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 6),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
