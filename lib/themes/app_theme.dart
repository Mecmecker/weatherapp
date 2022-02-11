import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 29, 0, 107);

  static const Shadow shadow =
      Shadow(color: Colors.black54, offset: Offset(2, 3), blurRadius: 5);

  static final ThemeData darkTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    scaffoldBackgroundColor: const Color.fromARGB(255, 1, 4, 26),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color.fromRGBO(1, 4, 26, 0.6),
      centerTitle: true,
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        shadows: [
          shadow,
        ],
      ),
    ),
    textTheme: TextTheme(
      headline5: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
      headline4: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.8)),
      headline3: TextStyle(fontSize: 36, color: Colors.white.withOpacity(0.8)),
    ),
  );
}
