import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/city_model.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';

class CountrySearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar ciudad';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      'build results: $query',
      style: const TextStyle(color: Colors.black),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _Background();
    }

    final CurrentWeatherProvider cityProvider =
        Provider.of<CurrentWeatherProvider>(context, listen: false);

    cityProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: cityProvider.suggestionStream,
      builder: (BuildContext _, AsyncSnapshot<List<CityModel>> snapshot) {
        if (!snapshot.hasData) {
          return _Background();
        }
        final List<CityModel> cities = snapshot.data!;

        return ListView.separated(
          itemBuilder: ((context, index) => _Sugerencia(city: cities[index])),
          itemCount: cities.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: Colors.grey, height: 2),
        );
      },
    );
  }
}

class _Sugerencia extends StatelessWidget {
  final CityModel city;
  const _Sugerencia({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        city.name + ', ' + city.country + ',  ' + city.countryA,
      ),
      trailing: const Icon(Icons.location_city_outlined),
      onTap: () {
        Navigator.pop(context, city);
      },
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(225, 253, 207, 122),
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _BackgroundPainter()),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.8, -0.7), // near the top right
      radius: 0.5,
      colors: <Color>[
        Color.fromARGB(180, 221, 138, 4), // yellow sun
        Color.fromARGB(180, 221, 91, 4), // blue sky
      ],
      stops: <double>[0.4, 1.0],
    );

    const RadialGradient gradient2 = RadialGradient(
      center: Alignment(0.8, -0.7), // near the top right
      radius: 1,
      colors: <Color>[
        Color.fromARGB(180, 221, 138, 4), // blue sky
        Color.fromARGB(180, 219, 161, 68), // yellow sun
      ],
      stops: <double>[0.6, 1.0],
    );

    final Paint sun = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final Paint line = Paint()
      ..color = const Color.fromARGB(180, 221, 138, 4)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final Paint lineSlim = Paint()
      ..shader = gradient2.createShader(rect)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, lineSlim);

    canvas.drawCircle(
        Offset(size.width * 9 / 10, size.height * 1 / 8), 160, sun);

    for (double i = 90; i <= 270; i += 30) {
      var x1 = (size.width * 9 / 10) + 180 * cos(i * pi / 180);
      var y1 = (size.height * 1 / 8) + 180 * sin(i * pi / 180);

      var x2 = (size.width * 9 / 10) + 215 * cos(i * pi / 180);
      var y2 = (size.height * 1 / 8) + 215 * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
