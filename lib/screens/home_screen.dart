import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/widgets.dart';

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
              Text(
                'Max 16º',
                style: style.headline4,
              ),
              const SizedBox(width: 5),
              Text('Min 6º', style: style.headline4),
              const SizedBox(width: 30),
              Text('5 Marzo 19:30', style: style.headline5),
            ],
          ),
          const SizedBox(height: 10),
          Text('Cielo bastante nublado', style: style.headline4)
        ],
      ),
    );
  }
}
