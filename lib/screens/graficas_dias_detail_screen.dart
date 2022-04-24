import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:intl/intl.dart' as intl;
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class GraficasDiasScreen extends StatelessWidget {
  const GraficasDiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DiasWeatherModel info =
        ModalRoute.of(context)!.settings.arguments as DiasWeatherModel;
    final Size size = MediaQuery.of(context).size;
    final timezone = Provider.of<CurrentWeatherProvider>(context).timezone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronóstico 16 dias'),
      ),
      body: Stack(
        children: [
          const Background(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              intl.DateFormat('EEEE, d, MMMM').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      (info.list[index].dt + timezone) * 1000)),
                              style: const TextStyle(fontSize: 20),
                            ),
                            InfoWidget(datos: info.list[index]),
                          ],
                        ),
                      );
                      //FichaInfo(datos: info.list[index]);
                    },
                    itemCount: info.list.length,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final ListElementSixteen datos;
  const InfoWidget({
    Key? key,
    required this.datos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        shadows: [Shadow(color: Colors.black38, blurRadius: 20)]);
    final photos = {
      '01': 'assets/sunnyland.jpg',
      '02': 'assets/sunnyland.jpg',
      '03': 'assets/sunnyland.jpg',
      '04': 'assets/sunnyland.jpg',
      '09': 'assets/rainlandscape.jpg',
      '10': 'assets/rainlandscape.jpg',
      '11': 'assets/stormland.jpg',
      '13': 'assets/snowland.jpg',
      '14': 'assets/sunnyland.jpg',
    };
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(photos[datos.weather[0].icon.substring(0, 2)]!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mañana: ' ' ' '${datos.temp.morn.round()}º',
                      style: style,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Mediodia: ' ' ' '${datos.temp.day.round()}º',
                      style: style,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tarde: ' ' ' '${datos.temp.eve.round()}º',
                      style: style,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Noche: ' ' ' '${datos.temp.night.round()}º',
                      style: style,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Lluvia', style: style),
                    Text(
                      '${(datos.pop.round()).toInt() * 100}%',
                      style: const TextStyle(fontSize: 30, shadows: [
                        Shadow(color: Colors.black38, blurRadius: 20)
                      ]),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Nubes',
                      style: style,
                    ),
                    Text(
                      '${datos.clouds}%',
                      style: const TextStyle(fontSize: 30, shadows: [
                        Shadow(color: Colors.black38, blurRadius: 20)
                      ]),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
