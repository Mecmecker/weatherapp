import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      headline6: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
      headline5: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
      headline4: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.8)),
      headline3: TextStyle(fontSize: 36, color: Colors.white.withOpacity(0.8)),
    ),
    iconTheme: IconThemeData(color: Colors.blueGrey.withOpacity(0.6), size: 36),
    dividerColor: Colors.white.withOpacity(0.1),
    listTileTheme: ListTileThemeData(
        iconColor: Colors.blueGrey.withOpacity(0.6), horizontalTitleGap: 10),
  );
}

String getCurrentDate() {
  return DateFormat('EEEE, d MMM').format(DateTime.now());
}

String getCurrenthour() {
  return DateFormat('h:mm a').format(DateTime.now());
}
