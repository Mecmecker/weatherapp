import 'package:weatherapp/models/models.dart';

class CityModel {
  String name, country, countryA;
  Coord cood;

  CityModel(
      {required this.name,
      required this.country,
      required this.countryA,
      required this.cood});
}
