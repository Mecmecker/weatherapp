import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/services/notification_service.dart';
import 'package:weatherapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context, listen: false);
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      // aqui creare la notificación del tiempo

      NotificationService().showNotifications(weatherProvider.weatherLocation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);
    weatherProvider.locationSearch = null;
    final calls = weatherProvider.callsWeather;

    return Scaffold(
      body: (calls.isEmpty)
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: const Center(child: CircularProgressIndicator()))
          : PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _Pantalla(call: calls[index], index: index);
              },
              itemCount: calls.length,
              scrollDirection: Axis.horizontal,
            ),
    );
  }
}

class _Pantalla extends StatelessWidget {
  final int index;
  const _Pantalla({
    Key? key,
    required this.call,
    required this.index,
  }) : super(key: key);

  final OneCallResponse call;

  @override
  Widget build(BuildContext context) {
    final CurrentWeatherProvider weatherProvider =
        Provider.of<CurrentWeatherProvider>(context);
    return RefreshIndicator(
      onRefresh: weatherProvider.refreshData,
      child: CustomScrollView(
        slivers: [
          CustomAppBar(weather: call),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                MaxMinDescription(weather: call),
                const Divider(),
                HorasInfoWidget(weather: call),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PercentCircle(
                        text: 'Humedad', valor: call.current.humidity),
                    PercentCircle(
                      text: 'Nubes',
                      valor: call.current.clouds,
                    ),
                  ],
                ),
                const Divider(),
                ActualWeatherWidgetsInfo(weather: call),
                const Divider(),
                DiasInfoWidget(weather: call),
                const SizedBox(height: 5),
                Graficas(weather: call),
              ],
            ),
          )
        ],
      ),
    );
  }
}
