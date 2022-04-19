import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/providers/current_weather_provider.dart';
import 'package:weatherapp/services/notification_service.dart';
import 'package:weatherapp/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

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
          ? Stack(
              children: [
                _Background(),
                Center(
                  child: Lottie.asset('assets/cargaNubes.json', repeat: true),
                ),
              ],
            )
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
    return Stack(children: [
      _Background(),
      RefreshIndicator(
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Row(
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
      ),
    ]);
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
