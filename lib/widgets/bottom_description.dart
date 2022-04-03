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

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(80),
        topLeft: Radius.circular(80),
        topRight: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          color: Colors.white.withOpacity(0.2),
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: size.height * 1 / 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _RichTextTemp(
                          style: style,
                          text: 'Max',
                          temp: weather.daily[0].temp.max.round()),
                      const SizedBox(width: 16),
                      _RichTextTemp(
                          style: style,
                          text: 'Min',
                          temp: weather.daily[0].temp.min.round()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 1 / 30,
                width: size.width * 0.55,
                child: FittedBox(
                  child: Text(weather.current.weather[0].description,
                      style: style.headline4),
                ),
              ),
              SizedBox(
                  width: size.width * 0.2,
                  child: FittedBox(
                      child: Text(getCurrentDate(), style: style.headline5))),
            ],
          ),
        ),
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
          TextSpan(text: ' $temp ºC', style: style.headline5)
        ],
      ),
    );
  }
}
