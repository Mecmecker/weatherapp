import 'dart:convert';

class Snow {
  Snow({
    this.the1H,
  });

  double? the1H;

  factory Snow.fromJson(String str) => Snow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Snow.fromMap(Map<String, dynamic> json) => Snow(
        the1H: json["1h"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "1h": the1H,
      };
}
