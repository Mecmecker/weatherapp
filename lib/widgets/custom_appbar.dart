import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';

import '../themes/themes.dart';

class CustomAppBar extends StatelessWidget {
  final OneCallResponse weather;

  const CustomAppBar({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: size.height - 130,
      floating: false,
      pinned: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'maps');
          },
          icon: const Icon(Icons.map_rounded)),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'search');
          },
          icon: const Icon(Icons.search),
        )
      ],
      centerTitle: true,
      automaticallyImplyLeading: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'https://torange.biz/photofxnew/1/HD/clear-sky-1049.jpg'),
              fit: BoxFit.cover,
            ),
            _InfoCenter(weather: weather),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        title: Text(
          weather.localizacion!.locality ?? '[${weather.lat},${weather.lon}',
          maxLines: 2,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              shadows: const [
                AppTheme.shadow,
              ],
              color: style.headline4?.color),
          textAlign: TextAlign.center,
        ),
        expandedTitleScale: 1.6,
        centerTitle: true,
      ),
    );
  }
}

class _InfoCenter extends StatelessWidget {
  final OneCallResponse weather;
  const _InfoCenter({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 250),
        Text(
          '${weather.current.temp.round()} ºC',
          style: const TextStyle(
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
                  SizedBox(
                    width: size.width * 0.75 - 10,
                    child: FittedBox(
                      child: Text(
                        weather.current.weather[0].description,
                        style: style.headline4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(
                            'http://openweathermap.org/img/wn/${weather.current.weather[0].icon}@2x.png')),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getCurrenthour(),
              style: style.headline4,
            ),
            const SizedBox(height: 20),
            if (Provider.of<CurrentWeatherProvider>(context).location ==
                weather.localizacion?.locality)
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
