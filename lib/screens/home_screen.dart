import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/widgets.dart';

import '../themes/themes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _MaxMinDescription(),
                const Divider(),
                const HorasInfoWidget(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    PercentCircle(text: 'Humidity'),
                    PercentCircle(text: 'Cloudiness'),
                  ],
                ),
                const Divider(),
                const ActualWeatherWidgetsInfo(),
                const Divider(),
                const DiasInfoWidget(),
                const SizedBox(height: 80),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MaxMinDescription extends StatelessWidget {
  const _MaxMinDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RichTextTemp(style: style, text: 'Max', temp: 16),
              const SizedBox(width: 10),
              _RichTextTemp(style: style, text: 'Min', temp: 6),
              const SizedBox(width: 30),
              Text(getCurrentDate(), style: style.headline5),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cielo bastante nublado', style: style.headline4),
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
