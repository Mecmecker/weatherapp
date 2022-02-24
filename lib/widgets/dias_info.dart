import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';

class DiasInfoWidget extends StatelessWidget {
  final OneCallResponse weather;

  const DiasInfoWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'dias',
          arguments: weatherProvider.infoPorDias[weatherProvider.infoPorDias
              .indexWhere((element) =>
                  element.city.coord.lat == weather.lat &&
                  element.city.coord.lon == weather.lon)]),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: ((context, index) =>
              _MiniDiaInfo(dailyInfo: weather.daily[index])),
          itemCount: weather.daily.length,
          itemExtent: 55,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class _MiniDiaInfo extends StatelessWidget {
  final Daily dailyInfo;
  const _MiniDiaInfo({Key? key, required this.dailyInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final timezone = Provider.of<CurrentWeatherProvider>(context).timezone;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, d').format(DateTime.fromMillisecondsSinceEpoch(
                (dailyInfo.dt + timezone) * 1000)),
            style: style.headline5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${dailyInfo.temp.max.round()}',
                  style: TextStyle(color: Colors.red[300], fontSize: 18),
                ),
                const TextSpan(text: ' | '),
                TextSpan(
                  text: '${dailyInfo.temp.min.round()}',
                  style: TextStyle(color: Colors.blue[300], fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(FontAwesomeIcons.temperatureHigh),
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: const Color.fromARGB(255, 0, 13, 29),
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(
              'http://openweathermap.org/img/wn/${dailyInfo.weather[0].icon}@2x.png'),
        ),
      ),
    );
  }
}
