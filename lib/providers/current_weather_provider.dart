import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/helpers/debouncer.dart';

import 'package:weatherapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/geolocator_service.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  final String _apiKey = dotenv.env['API_KEY']!;
  final String _baseUrl = 'pro.openweathermap.org';
  final String _language = 'es';
  final String _units = 'metric';

  //api de autocomplete

  final String _apiKeyCity = dotenv.env['API_KEY_CITY']!;

  String _location = '';
  String get location => _location;

  CityModel? locationSearch;

  final int timezone = 3600;

  List<OneCallResponse> callsWeather = [];

  //Pruebas para las graficas de tiempo
  List<HorasModel> infoPorHoras = [];
  List<DiasWeatherModel> infoPorDias = [];

  final Map<String, List<String>> mapCities = {
    'Cerdanyola del Vallès': ['41.49064359025308', '2.1356232423292703'],
    'Barcelona': ['41.385675742914465', '2.1705880101786517'],
    'Madrid': ['40.41674014299714', '-3.699408682989556'],
    'L\'Hospitalet de LLobregat': ['41.3597', '2.1003'],
    'Bruselas': ['50.88632783626364', '4.355948189844188'],
    'Rzeszów': ['50.03838599493068', '21.98115834592852'],
  };
  void updateWeather(List<String> geo) {
    getOneCallWeather(geo);
    getFourDayHourlyWeather(geo);
    getSixteenDaysWeather(geo);
    notifyListeners();
  }

  void addCity(Map<String, List<String>> city) {
    mapCities.addAll(city);

    notifyListeners();
  }

  final GeolocatorService _geolocatorService = GeolocatorService();

  Position? currentLocation;

  final StreamController<List<CityModel>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<CityModel>> get suggestionStream =>
      _suggestionStreamController.stream;

  final Debouncer debounce =
      Debouncer(duration: const Duration(milliseconds: 500));

  Future<List<String>> setCurrentLocation() async {
    currentLocation = await _geolocatorService.getCurrentLocation();

    notifyListeners();
    if (currentLocation != null) {
      return [
        currentLocation!.latitude.toString(),
        currentLocation!.longitude.toString()
      ];
    } else {
      return <String>[];
    }
  }

  Future<Placemark> getUbicacion(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    return placemarks[0];
  }

  //init

  CurrentWeatherProvider() {
    getCurrentLocationWeather();

    mapCities.forEach((key, value) {
      getOneCallWeather(value);
      getFourDayHourlyWeather(value);
      getSixteenDaysWeather(value);
    });
  }

  //shred preferences functions

// weathers calls
  Future<String> _getJsonDataByGeo(
      String endpoint, String lat, String lon) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'lat': lat,
      'lon': lon,
      'APPID': _apiKey,
      'lang': _language,
      'units': _units
    });
    final response = await http.get(url);
    return response.body;
  }

  getOneCallWeather(List<String> geo) async {
    final jsonData =
        await _getJsonDataByGeo('data/2.5/onecall', geo[0], geo[1]);
    final OneCallResponse currentCall = OneCallResponse.fromJson(jsonData);
    final localizacion = await getUbicacion(currentCall.lat, currentCall.lon);

    currentCall.localizacion = localizacion;
    callsWeather.add(currentCall);

    notifyListeners();
  }

  getFourDayHourlyWeather(List<String> geo) async {
    final jsonData =
        await _getJsonDataByGeo('data/2.5/forecast/hourly', geo[0], geo[1]);
    final HorasModel currentCall = HorasModel.fromJson(jsonData);
    infoPorHoras.add(currentCall);
    notifyListeners();
  }

  getSixteenDaysWeather(List<String> geo) async {
    final jsonData =
        await _getJsonDataByGeo('data/2.5/forecast/daily', geo[0], geo[1]);
    final DiasWeatherModel currentCall = DiasWeatherModel.fromJson(jsonData);
    infoPorDias.add(currentCall);
    notifyListeners();
  }

  getCurrentLocationWeather() async {
    final geo = await setCurrentLocation();
    if (geo.isNotEmpty) {
      await getUbicacion(double.parse(geo[0]), double.parse(geo[1]))
          .then((value) => _location = value.locality!);
      getOneCallWeather(geo);
      getFourDayHourlyWeather(geo);
      getFourDayHourlyWeather(geo);
    }
  }

  //autocomplete
  Future<List<CityModel>> searchCity(String query) async {
    final url = Uri.https("app.geocodeapi.io", 'api/v1/autocomplete', {
      'text': query,
      'apikey': _apiKeyCity,
    });
    final response = await http.get(url);
    final autosearch = AutocompleteSearchModel.fromJson(response.body);

    return [
      for (Feature f in autosearch.features)
        CityModel(
            name: f.properties.name,
            country: f.properties.country ?? '',
            countryA: f.properties.countryA ?? '',
            cood: Coord(
                lon: f.geometry.coordinates[0], lat: f.geometry.coordinates[1]))
    ];
  }

  getSuggestionsByQuery(String valor) {
    debounce.value = '';
    debounce.onValue = (value) async {
      final results = await searchCity(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debounce.value = valor;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
