import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/models/models.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherProvider extends ChangeNotifier {
  final String _apiKey = dotenv.env['API_KEY']!;
  final String _baseUrl = 'pro.openweathermap.org';
  final String _language = 'es';
  final String _units = 'metric';

  final int timezone = 3600;

  //Para pruebas, Luego se leeran de los favoritos guardados
  final List<String> _cities = ['Barcelona', 'Madrid', 'Cerdanyola del Vallès'];

  List<CurrentWeather> currentWeathers = [];

  final String _lat = '41.49064359025308';
  final String _lon = '2.1356232423292703';

  List<OneCallResponse> callsWeather = [];

  CurrentWeatherProvider() {
    for (var city in _cities) {
      getCurrentWeatherByCity(city);
    }
    getOnCallWeather();
  }

  Future<String> _getJsonData(String endpoint, String city) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'q': city, 'APPID': _apiKey, 'lang': _language, 'units': _units});
    final response = await http.get(url);
    return response.body;
  }

  getCurrentWeatherByCity(String city) async {
    final jsonData = await _getJsonData('data/2.5/weather', city);
    final CurrentWeather currentWeather = CurrentWeather.fromJson(jsonData);
    currentWeathers.add(currentWeather);

    notifyListeners();
  }

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

  getOnCallWeather() async {
    final jsonData = await _getJsonDataByGeo('data/2.5/onecall', _lat, _lon);
    final OneCallResponse currentCall = OneCallResponse.fromJson(jsonData);
    callsWeather.add(currentCall);

    notifyListeners();
  }
}
