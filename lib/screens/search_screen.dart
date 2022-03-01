import 'dart:async';

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
  CameraUpdate? update;
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider currentWeatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: LatLng(currentWeatherProvider.currentLocation!.latitude,
            currentWeatherProvider.currentLocation!.longitude),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                showSearch(context: context, delegate: CountrySearchDelegate())
                    .then((city) {
                  cityName = city.name;
                  markers.add(
                    Marker(
                      markerId: MarkerId(city.name),
                      position: LatLng(city.cood.lat, city.cood.lon),
                    ),
                  );
                  update = CameraUpdate.newLatLng(
                      LatLng(city.cood.lat, city.cood.lon));
                  changePosition(update!);

                  setState(() {});
                });
              },
              child: Text(cityName ?? currentWeatherProvider.location)),
          if (currentWeatherProvider.currentLocation != null)
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentWeatherProvider.currentLocation!.latitude,
                        currentWeatherProvider.currentLocation!.longitude),
                    zoom: 16,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                    setState(() {
                      _mapController = controller;
                    });
                  },
                  markers: markers,
                ),
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

  changePosition(CameraUpdate update) {
    _mapController.animateCamera(update);
    _mapController.moveCamera(update);
  }
}
