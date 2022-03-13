import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class LayeredMapsScreen extends StatefulWidget {
  const LayeredMapsScreen({Key? key}) : super(key: key);

  @override
  State<LayeredMapsScreen> createState() => _LayeredMapsScreenState();
}

class _LayeredMapsScreenState extends State<LayeredMapsScreen> {
  final String _apiKey = dotenv.env['API_KEY']!;

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider currentWeatherProvider =
        Provider.of<CurrentWeatherProvider>(context);
    final LayerProvider layerProvider = Provider.of<LayerProvider>(context);
    final List<String> layers = ['TA2', 'PR0', 'WND', 'CL', 'PA0'];
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            child: _SelectLayerBar()),
      ),
      body: FlutterMap(
        options: MapOptions(
            center: currentWeatherProvider.coord,
            zoom: 5.0,
            maxZoom: 20,
            minZoom: 4,
            screenSize: MediaQuery.of(context).size),
        nonRotatedLayers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          layerMap(layers[layerProvider.layerPos],
              layerPalette[layers[layerProvider.layerPos]]!),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 50.0,
                height: 50.0,
                point: currentWeatherProvider.coord == null
                    ? LatLng(1, 1)
                    : currentWeatherProvider.coord!,
                builder: (ctx) => const Icon(Icons.location_on_rounded),
              ),
            ],
          ),
        ],
        nonRotatedChildren: <Widget>[
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate:
                  "http://maps.openweathermap.org/maps/2.0/weather/TA2/{z}/{x}/{y}?appid=$_apiKey",
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectLayerBar extends StatelessWidget {
  const _SelectLayerBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LayerProvider layerProvider = Provider.of<LayerProvider>(context);
    return BottomNavigationBar(
      currentIndex: layerProvider.layerPos,
      onTap: (pos) {
        layerProvider.layerPos = pos;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.thermostat),
          label: 'Temperatura',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Lluvia',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.window),
          label: 'Viento',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart_rounded),
          label: 'Nubes',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart_rounded),
          label: 'Lluvia acumulada',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
      ],
    );
  }
}

TileLayerOptions layerMap(String opt, String palette) {
  final String _apiKey = dotenv.env['API_KEY']!;
  return TileLayerOptions(
      urlTemplate:
          "http://maps.openweathermap.org/maps/2.0/weather/$opt/{z}/{x}/{y}?appid=$_apiKey",
      opacity: 0.8,
      additionalOptions: {'palette': palette});
}

Map<String, String> layerPalette = {
  'TA2':
      '-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014',
  'PR0':
      '0.000005:FEF9CA; 0.000009:B9F7A8; 0.000014:93F57D; 0.000023:78F554; 0.000046:50B033; 0.000092:387F22; 0.000231:204E11; 0.000463:F2A33A; 0.000694:E96F2D; 0.000926:EB4726; 0.001388:B02318; 0.002315:971D13; 0.023150:090A08',
  'WND':
      '1:FFFFFF00; 5:EECECC66; 15:B364BCB3; 25:3F213BCC; 50:744CACE6; 100:4600AFFF; 200:0D1126FF',
  'CL':
      '0:FFFFFF00; 10:FDFDFF19; 20:FCFBFF26; 30:FAFAFF33; 40:F9F8FF4C; 50:F7F7FF66; 60:F6F5FF8C; 70:F4F4FFBF; 80:E9E9DFCC; 90:DEDEDED8; 100:D2D2D2FF; 200:D2D2D2FF',
  'PA0':
      '0:00000000; 0.1:C8969600; 0.2:9696AA00; 0.5:7878BE19; 1:6E6ECD33; 10:5050E1B2; 140:1414FFE5',
};
