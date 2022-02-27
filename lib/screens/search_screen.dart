import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/search/search_delegate.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider currentWeatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
      ),
      body: ListView(
        children: [
          TextButton(
              onPressed: () {
                showSearch(context: context, delegate: CountrySearchDelegate());
              },
              child: Text(cityName ?? currentWeatherProvider.location)),
          if (currentWeatherProvider.currentLocation != null)
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentWeatherProvider.currentLocation!.latitude,
                      currentWeatherProvider.currentLocation!.longitude),
                  zoom: 17,
                ),
                mapType: MapType.normal,
                myLocationEnabled: true,
              ),
            ),
          if (currentWeatherProvider.currentLocation == null)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            )
        ],
      ),
    );
  }
}
