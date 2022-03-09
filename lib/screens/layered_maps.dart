import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/current_weather_provider.dart';

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
    return FlutterMap(
      options: MapOptions(
          zoom: 8.0,
          maxZoom: 20,
          minZoom: 4,
          screenSize: MediaQuery.of(context).size),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        TileLayerOptions(
            urlTemplate:
                "http://maps.openweathermap.org/maps/2.0/weather/PR0/{z}/{x}/{y}?appid=$_apiKey",
            opacity: 0.6),
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
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate:
                "http://maps.openweathermap.org/maps/2.0/weather/TA2/{z}/{x}/{y}?appid=$_apiKey",
          ),
        ),
      ],
    );
  }
}
