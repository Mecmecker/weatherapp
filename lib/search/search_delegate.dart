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
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('build results: $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.map_outlined,
          size: 150,
        ),
      );
    }

    final CurrentWeatherProvider cityProvider =
        Provider.of<CurrentWeatherProvider>(context, listen: false);

    cityProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: cityProvider.suggestionStream,
      builder: (BuildContext _, AsyncSnapshot<List<CityModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.map_outlined,
              size: 150,
            ),
          );
        }
        final List<CityModel> cities = snapshot.data!;

        return ListView.builder(
          itemBuilder: ((context, index) => _Sugerencia(city: cities[index])),
          itemCount: cities.length,
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
        city.name + ',' + city.country + ',' + city.countryA,
      ),
      onTap: () {
        Navigator.pop(context, city);
      },
    );
  }
}
