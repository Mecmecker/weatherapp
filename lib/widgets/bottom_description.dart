import 'package:flutter/material.dart';

import '../models/models.dart';
import '../themes/themes.dart';

class MaxMinDescription extends StatelessWidget {
  final OneCallResponse weather;
  const MaxMinDescription({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RichTextTemp(
                  style: style,
                  text: 'Max',
                  temp: weather.daily[0].temp.max.round()),
              const SizedBox(width: 20),
              _RichTextTemp(
                  style: style,
                  text: 'Min',
                  temp: weather.daily[0].temp.min.round()),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.6,
                child: FittedBox(
                  child: Text(weather.current.weather[0].description,
                      style: style.headline4),
                ),
              ),
              SizedBox(
                  width: size.width * 0.3 - 10,
                  child: FittedBox(
                      child: Text(getCurrentDate(), style: style.headline5))),
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
