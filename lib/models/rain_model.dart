import 'dart:convert';

class Rain {
  Rain({
    this.the1H,
  });

  double? the1H;

  factory Rain.fromJson(String str) => Rain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
        the1H: json["1h"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "1h": the1H,
      };
}
