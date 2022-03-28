import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import '../models/models.dart';
import '../providers/providers.dart';

class FichaInfo extends StatelessWidget {
  final ListElementSixteen datos;

  const FichaInfo({
    Key? key,
    required this.datos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timezone = Provider.of<CurrentWeatherProvider>(context).timezone;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            intl.DateFormat('EEEE, d, MMMM').format(
                DateTime.fromMillisecondsSinceEpoch(
                    (datos.dt + timezone) * 1000)),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(40)),
            child: Container(
              width: double.infinity,
              height: 180,
              color: Colors.white.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 150,
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(
                          'http://openweathermap.org/img/wn/${datos.weather[0].icon}@2x.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Morning:'),
                      Text('Day: '),
                      Text('Evening: '),
                      Text('Night: '),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${datos.temp.morn.round()}º'),
                      Text('${datos.temp.day.round()}º'),
                      Text('${datos.temp.eve.round()}º'),
                      Text('${datos.temp.night.round()}º'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      const Text('Lluvia'),
                      Text(
                        '${(datos.pop.round()).toInt() * 100}%',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                      const Text('Nubes'),
                      Text(
                        '${datos.clouds}%',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
