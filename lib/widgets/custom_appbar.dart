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
    final location = Provider.of<CurrentWeatherProvider>(context).location;

    final photos = {
      '01': 'assets/sunny.jpg',
      '02': 'assets/pocasnubes.jpg',
      '03': 'assets/nubes.jpg',
      '04': 'assets/brokenclouds.jpg',
      '09': 'assets/lluvia.jpg',
      '10': 'assets/chispa.jpg',
      '11': 'assets/strom.jpg',
      '13': 'assets/snow.jpg',
      '14': 'assets/mist.jpg',
    };

    return SliverAppBar(
      expandedHeight: size.height - 35,
      floating: false,
      pinned: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
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
        ),
        if (location != weather.localizacion?.locality)
          IconButton(
            onPressed: Provider.of<CurrentWeatherProvider>(context)
                    .mapCities
                    .containsKey(weather.localizacion!.locality!)
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Borrado'),
                        action: SnackBarAction(
                            label: 'Deshacer',
                            onPressed: () {
                              Provider.of<CurrentWeatherProvider>(context,
                                      listen: false)
                                  .addLocation(
                                weather.localizacion!.locality!,
                                [
                                  weather.lat.toString(),
                                  weather.lon.toString(),
                                ],
                              );
                            }),
                      ),
                    );
                    Provider.of<CurrentWeatherProvider>(context, listen: false)
                        .removeLocation(weather.localizacion!.locality!);
                  }
                : () {
                    Provider.of<CurrentWeatherProvider>(context, listen: false)
                        .addLocation(
                      weather.localizacion!.locality!,
                      [
                        weather.lat.toString(),
                        weather.lon.toString(),
                      ],
                    );
                  },
            icon: Provider.of<CurrentWeatherProvider>(context)
                    .mapCities
                    .containsKey(weather.localizacion!.locality!)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                  ),
          )
      ],
      centerTitle: true,
      automaticallyImplyLeading: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: AssetImage(
                  photos[weather.current.weather[0].icon.substring(0, 2)]!),
              fit: BoxFit.cover,
            ),
            _InfoCenter(weather: weather),
            const Align(
              alignment: Alignment(0.92, 0.98),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            const Align(
              alignment: Alignment(0.92, 1),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            const Align(
              alignment: Alignment(-0.92, 0.98),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            const Align(
              alignment: Alignment(-0.92, 1),
              child: Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        title: Text(
          weather.localizacion!.locality == ''
              ? weather.localizacion!.subAdministrativeArea!
              : weather.localizacion!.locality ??
                  '[${weather.lat},${weather.lon}',
          maxLines: 2,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              shadows: const [
                AppTheme.shadow,
              ],
              color: style.headline4?.color),
          textAlign: TextAlign.center,
        ),
        expandedTitleScale: 1.5,
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
          '${weather.current.temp.round()} ??C',
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
            if (weather.localizacion!.street != '')
              SizedBox(
                width: size.width * 0.5 - 10,
                child: FittedBox(
                  child: Text(
                    weather.localizacion!.street!,
                    style: style.headline4,
                  ),
                ),
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
