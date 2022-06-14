import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/helpers/debouncer.dart';
import 'package:latlong2/latlong.dart';
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

  OneCallResponse? weatherLocation;

  //Pruebas para las graficas de tiempo
  List<HorasModel> infoPorHoras = [];
  List<DiasWeatherModel> infoPorDias = [];

  Map<String, dynamic> mapCities = {};

  void updateWeather(List<String> geo) {
    getOneCallWeather(geo);
    getFourDayHourlyWeather(geo);
    getSixteenDaysWeather(geo);
    notifyListeners();
  }

  void addCity(Map<String, List<String>> city) {
    mapCities.addAll(city);
    saveDataPreferences();
    refreshData();
    notifyListeners();
  }

  final GeolocatorService _geolocatorService = GeolocatorService();

  Position? currentLocation;
  LatLng? coord;

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
      coord = LatLng(currentLocation!.latitude, currentLocation!.longitude);
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
    getDataPreferences();
  }

  Future<void> refreshData() async {
    callsWeather.clear();
    infoPorDias.clear();
    infoPorHoras.clear();

    getCurrentLocationWeather();
    getDataPreferences();
  }

  //shred preferences functions

  Future<void> saveDataPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    prefs.setString('datos', jsonEncode(mapCities));
  }

  void removeLocation(String location) {
    mapCities.remove(location);
    saveDataPreferences();
    notifyListeners();
  }

  void addLocation(String name, List<String> coord) {
    if (mapCities.containsKey(name) == false) mapCities[name] = coord;
    saveDataPreferences();
    notifyListeners();
  }

  Future<void> getDataPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final datosJson = prefs.getString('datos');
    if (datosJson != null) {
      mapCities = Map<String, dynamic>.from(jsonDecode(datosJson));

      mapCities.forEach((key, value) {
        getOneCallWeather(value);
        getFourDayHourlyWeather(value);
        getSixteenDaysWeather(value);
      });
    }
  }

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

  Future<String> _getJsonDataByGeo16days(
      String endpoint, String lat, String lon) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'lat': lat,
      'lon': lon,
      'APPID': _apiKey,
      'lang': _language,
      'units': _units,
      'cnt': '16'
    });
    final response = await http.get(url);
    return response.body;
  }

  void getOneCallWeather(List<dynamic> geo) async {
    final jsonData =
        await _getJsonDataByGeo('data/2.5/onecall', geo[0], geo[1]);
    final OneCallResponse currentCall = OneCallResponse.fromJson(jsonData);
    final localizacion = await getUbicacion(currentCall.lat, currentCall.lon);

    currentCall.localizacion = localizacion;
    callsWeather.add(currentCall);

    if (localizacion.locality == _location) {
      weatherLocation = currentCall;
    }

    notifyListeners();
  }

  void getFourDayHourlyWeather(List<dynamic> geo) async {
    final jsonData =
        await _getJsonDataByGeo('data/2.5/forecast/hourly', geo[0], geo[1]);
    final HorasModel currentCall = HorasModel.fromJson(jsonData);
    infoPorHoras.add(currentCall);
    notifyListeners();
  }

  void getSixteenDaysWeather(List<dynamic> geo) async {
    final jsonData = await _getJsonDataByGeo16days(
        'data/2.5/forecast/daily', geo[0], geo[1]);
    final DiasWeatherModel currentCall = DiasWeatherModel.fromJson(jsonData);
    infoPorDias.add(currentCall);
    notifyListeners();
  }

  void getCurrentLocationWeather() async {
    final geo = await setCurrentLocation();
    if (geo.isNotEmpty) {
      await getUbicacion(double.parse(geo[0]), double.parse(geo[1]))
          .then((value) => _location = value.locality!);
      getOneCallWeather(geo);
      getFourDayHourlyWeather(geo);
      getSixteenDaysWeather(geo);
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

  void getSuggestionsByQuery(String valor) {
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
