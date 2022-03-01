import 'dart:convert';

class AutocompleteSearchModel {
  AutocompleteSearchModel({
    required this.features,
  });

  List<Feature> features;

  factory AutocompleteSearchModel.fromJson(String str) =>
      AutocompleteSearchModel.fromMap(json.decode(str));

  factory AutocompleteSearchModel.fromMap(Map<String, dynamic> json) =>
      AutocompleteSearchModel(
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
      );
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  String type;
  Geometry geometry;
  Properties properties;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: json["type"],
        geometry: Geometry.fromMap(json["geometry"]),
        properties: Properties.fromMap(json["properties"]),
      );
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );
}

class Properties {
  Properties({
    required this.name,
    this.country,
    this.region,
    this.localadmin,
    this.locality,
    required this.continent,
    required this.label,
    this.countryA,
  });

  String name;
  String? country;
  String? region;
  String? localadmin;
  String? locality;
  String continent;
  String label;
  String? countryA;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        name: json["name"],
        country: json["country"],
        region: json["region"],
        localadmin: json["localadmin"],
        locality: json["locality"],
        continent: json["continent"],
        label: json["label"],
        countryA: json["country_a"],
      );
}
