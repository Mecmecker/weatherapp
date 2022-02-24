// To parse this JSON data, do
//
//     final diasWeatherModel = diasWeatherModelFromMap(jsonString);

import 'dart:convert';

import 'package:weatherapp/models/models.dart';

class DiasWeatherModel {
  DiasWeatherModel({
    required this.city,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  CitySixteen city;
  String cod;
  double message;
  int cnt;
  List<ListElementSixteen> list;

  factory DiasWeatherModel.fromJson(String str) =>
      DiasWeatherModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiasWeatherModel.fromMap(Map<String, dynamic> json) =>
      DiasWeatherModel(
        city: CitySixteen.fromMap(json["city"]),
        cod: json["cod"],
        message: json["message"].toDouble(),
        cnt: json["cnt"],
        list: List<ListElementSixteen>.from(
            json["list"].map((x) => ListElementSixteen.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "city": city.toMap(),
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toMap())),
      };
}

class CitySixteen {
  CitySixteen({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
  });

  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;

  factory CitySixteen.fromJson(String str) =>
      CitySixteen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CitySixteen.fromMap(Map<String, dynamic> json) => CitySixteen(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromMap(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "coord": coord.toMap(),
        "country": country,
        "population": population,
        "timezone": timezone,
      };
}

class ListElementSixteen {
  ListElementSixteen({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.weather,
    required this.speed,
    required this.deg,
    required this.gust,
    required this.clouds,
    required this.pop,
    this.rain,
  });

  int dt;
  int sunrise;
  int sunset;
  TempSixteen temp;
  FeelsLikeSixteen feelsLike;
  int pressure;
  int humidity;
  List<Weather> weather;
  double speed;
  int deg;
  double gust;
  int clouds;
  double pop;
  double? rain;

  factory ListElementSixteen.fromJson(String str) =>
      ListElementSixteen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElementSixteen.fromMap(Map<String, dynamic> json) =>
      ListElementSixteen(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: TempSixteen.fromMap(json["temp"]),
        feelsLike: FeelsLikeSixteen.fromMap(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
        clouds: json["clouds"],
        pop: json["pop"].toDouble(),
        rain: json["rain"] == null ? null : json["rain"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp.toMap(),
        "feels_like": feelsLike.toMap(),
        "pressure": pressure,
        "humidity": humidity,
        "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
        "speed": speed,
        "deg": deg,
        "gust": gust,
        "clouds": clouds,
        "pop": pop,
        "rain": rain == null ? null : rain,
      };
}

class FeelsLikeSixteen {
  FeelsLikeSixteen({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double night;
  double eve;
  double morn;

  factory FeelsLikeSixteen.fromJson(String str) =>
      FeelsLikeSixteen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeelsLikeSixteen.fromMap(Map<String, dynamic> json) =>
      FeelsLikeSixteen(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class TempSixteen {
  TempSixteen({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  factory TempSixteen.fromJson(String str) =>
      TempSixteen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TempSixteen.fromMap(Map<String, dynamic> json) => TempSixteen(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}
