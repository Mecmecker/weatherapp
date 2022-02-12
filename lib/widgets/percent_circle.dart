import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentCircle extends StatelessWidget {
  final String text;
  const PercentCircle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80,
      percent: 0.7,
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
              const Text(
                '70%',
                style: TextStyle(fontSize: 36),
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
