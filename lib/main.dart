import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/providers.dart';

import 'package:weatherapp/screens/screens.dart';
import 'package:weatherapp/services/notification_service.dart';
import 'package:weatherapp/themes/themes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load();
  await initializeDateFormatting(await findSystemLocale(), null);
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext _) => CurrentWeatherProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (BuildContext _) => LayerProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'intro',
      routes: {
        'home': (context) => const HomeScreen(),
        'horas': (context) => const GraficasHorasScreen(),
        'dias': (context) => const GraficasDiasScreen(),
        'search': (context) => const SearchScreen(),
        'maps': ((context) => const LayeredMapsScreen()),
        'intro': ((context) => const IntroPage()),
      },
      theme: AppTheme.darkTheme,
    );
  }
}
