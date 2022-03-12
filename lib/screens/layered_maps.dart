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
    final List<String> layers = ['PAC0', 'PR0', 'PA0', 'TA2'];
    return Scaffold(
      bottomNavigationBar: const _SelectLayerBar(),
      body: FlutterMap(
        options: MapOptions(
            zoom: 8.0,
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
                point: currentWeatherProvider.currentLocation == null
                    ? LatLng(1, 1)
                    : LatLng(currentWeatherProvider.currentLocation!.latitude,
                        currentWeatherProvider.currentLocation!.longitude),
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
          icon: Icon(Icons.cloud),
          label: 'lluvia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thermostat),
          label: 'temperatura',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.window),
          label: 'viento',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart_rounded),
          label: 'humedad',
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
      opacity: 0.6,
      additionalOptions: {'palette': palette});
}

Map<String, String> layerPalette = {
  'PAC0': '1:ACAAF7; 10:8D8AF3; 20:706EC2; 40:5658FF; 100:5B5DB1; 200:3E3F85',
  'PR0':
      '0.000005:FEF9CA; 0.000009:B9F7A8; 0.000014:93F57D; 0.000023:78F554; 0.000046:50B033; 0.000092:387F22; 0.000231:204E11; 0.000463:F2A33A; 0.000694:E96F2D; 0.000926:EB4726; 0.001388:B02318; 0.002315:971D13; 0.023150:090A08',
  'PA0':
      '0:00000000; 0.1:C8969600; 0.2:9696AA00; 0.5:7878BE19; 1:6E6ECD33; 10:5050E1B2; 140:1414FFE5',
  'TA2':
      '-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014',
};
