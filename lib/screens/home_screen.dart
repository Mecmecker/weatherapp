import 'package:flutter/material.dart';
import 'package:weatherapp/themes/themes.dart';

import 'package:weatherapp/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _MaxMinDescription(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    PercentCircle(text: 'Humidity'),
                    PercentCircle(text: 'Cloudiness'),
                  ],
                ),
                const Divider(),
                const _ActualWeatherWidgetsInfo(),
                const Divider(),
                Container(
                  height: 1000,
                  color: const Color.fromARGB(255, 1, 4, 26),
                ),
                const Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ActualWeatherWidgetsInfo extends StatelessWidget {
  const _ActualWeatherWidgetsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: const [
          MiniInfoCard(
            text: 'Viento',
            icon: FontAwesomeIcons.wind,
            unidades: 'm/s',
          ),
          MiniInfoCard(
              text: 'Sensación termica',
              icon: FontAwesomeIcons.thermometerEmpty,
              unidades: 'ºC'),
          MiniInfoCard(
              text: 'Presión', icon: FontAwesomeIcons.compass, unidades: 'hPa'),
          MiniInfoCard(
              text: 'Visibilidad',
              icon: FontAwesomeIcons.lowVision,
              unidades: 'Km'),
          MiniInfoCard(
              text: 'Temperatura',
              icon: FontAwesomeIcons.temperatureHigh,
              unidades: 'ºC'),
          // si hay info de lluvia o nieve se añadira if()
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

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: size.height - 130,
      floating: false,
      pinned: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      centerTitle: true,
      automaticallyImplyLeading: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: const [
            FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'https://torange.biz/photofxnew/1/HD/clear-sky-1049.jpg'),
              fit: BoxFit.cover,
            ),
            _InfoCenter(),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        title: const Text(
          'Cerdanyola del vallés',
          maxLines: 2,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            shadows: [
              AppTheme.shadow,
            ],
          ),
          textAlign: TextAlign.center,
        ),
        expandedTitleScale: 1.6,
        centerTitle: true,
      ),
    );
  }
}

class _InfoCenter extends StatelessWidget {
  const _InfoCenter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 250),
        const Text(
          '16ºC',
          style: TextStyle(
            fontSize: 80,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              AppTheme.shadow,
            ],
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nublado',
                    style: style.headline4,
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.cloud)
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.location_on_sharp,
              size: 40,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
