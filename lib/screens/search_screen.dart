import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider currentWeatherProvider =
        Provider.of<CurrentWeatherProvider>(context);

    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: LatLng(currentWeatherProvider.currentLocation!.latitude,
            currentWeatherProvider.currentLocation!.longitude),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      showSearch(
                              context: context,
                              delegate: CountrySearchDelegate())
                          .then((city) {
                        currentWeatherProvider.locationSearch = city;
                        cityName = city.name;
                        update = CameraUpdate.newLatLng(
                            LatLng(city.cood.lat, city.cood.lon));
                        changePosition(update!);
                        setState(() {
                          markers.add(
                            Marker(
                              markerId: MarkerId(city.name),
                              position: LatLng(city.cood.lat, city.cood.lon),
                            ),
                          );
                        });
                      });
                    },
                    child: Text(cityName ?? currentWeatherProvider.location),
                  ),
                  const Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 14,
                  )
                ],
              ),
            ),
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
                    onTap: _changePlace,
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
            if (currentWeatherProvider.locationSearch != null)
              _ButtonBack(city: currentWeatherProvider.locationSearch!),
            if (currentWeatherProvider.currentLocation == null)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          ],
        ),
      ),
    );
  }

  changePosition(CameraUpdate update) {
    _mapController.animateCamera(update);
    _mapController.moveCamera(update);
  }

  _changePlace(LatLng tappedPoint) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('New position'),
        position: tappedPoint,
      ),
    );
    final cityProvider =
        Provider.of<CurrentWeatherProvider>(context, listen: false);

    setState(() {});
    cityProvider
        .getUbicacion(tappedPoint.latitude, tappedPoint.longitude)
        .then((value) {
      setState(() {
        cityName = value.locality;
        cityProvider.locationSearch = CityModel(
            name: value.locality ?? '',
            country: value.country ?? '',
            countryA: '',
            cood: Coord(lon: tappedPoint.longitude, lat: tappedPoint.latitude));
      });
    });
  }
}

class _ButtonBack extends StatelessWidget {
  final CityModel city;
  const _ButtonBack({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final weatherProvider =
            Provider.of<CurrentWeatherProvider>(context, listen: false);
        weatherProvider.addCity({
          city.name: [city.cood.lat.toString(), city.cood.lon.toString()]
        });
        weatherProvider.updateWeather(
            [city.cood.lat.toString(), city.cood.lon.toString()]);

        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Añadir',
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(width: 7),
          Icon(
            FontAwesomeIcons.heart,
            size: 20,
          ),
        ],
      ),
    );
  }
}
