import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';

class HorasInfoWidget extends StatelessWidget {
  const HorasInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    final calls = weatherProvider.callsWeather;

    return SizedBox(
      height: 120,
      width: double.infinity,
      child: calls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: ((context, index) =>
                  _MiniHoraInfo(info: calls[0].hourly[index])),
              itemCount: calls[0].hourly.length,
              scrollDirection: Axis.horizontal,
            ),
    );
  }
}

class _MiniHoraInfo extends StatelessWidget {
  final Current info;
  const _MiniHoraInfo({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timezone = Provider.of<CurrentWeatherProvider>(context).timezone;
    final style = Theme.of(context).textTheme;
    return SizedBox(
      height: 90,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(
                (info.dt + timezone) * 1000)),
            style: style.headline6,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(255, 0, 13, 29),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'http://openweathermap.org/img/wn/${info.weather[0].icon}@2x.png'),
            ),
          ),
          Text('${info.temp.round()}ºC', style: style.headline5)
        ],
      ),
    );
  }
}
