class GeoCoods {
  String name;
  List<String> geo;

  GeoCoods({required this.name, required this.geo});

  Map<String, dynamic> toJson() => {
        'name': name,
        'geo': geo,
      };

  GeoCoods.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        geo = json['geo'];
}
