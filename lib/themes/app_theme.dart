import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 29, 0, 107);
  //Colors.blueGrey.withOpacity(0.6)

  static const Shadow shadow =
      Shadow(color: Colors.black54, offset: Offset(2, 3), blurRadius: 5);

  static final ThemeData darkTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    primaryColorDark: const Color.fromARGB(255, 1, 4, 26),
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
    iconTheme:
        const IconThemeData(color: Color.fromARGB(255, 4, 96, 112), size: 36),
    dividerColor: Colors.white.withOpacity(0.1),
    listTileTheme: const ListTileThemeData(
        iconColor: Color.fromARGB(255, 4, 96, 112), horizontalTitleGap: 10),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    primaryColorDark: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black),
      elevation: 0,
      color: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        shadows: [
          shadow,
        ],
      ),
    ),
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8)),
      headline5: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
      headline4: TextStyle(fontSize: 28, color: Colors.black.withOpacity(0.8)),
      headline3: TextStyle(fontSize: 36, color: Colors.black.withOpacity(0.8)),
    ),
    iconTheme:
        const IconThemeData(color: Color.fromARGB(255, 4, 96, 112), size: 36),
    dividerColor: Colors.black.withOpacity(0.1),
    listTileTheme: const ListTileThemeData(
        iconColor: Color.fromARGB(255, 4, 96, 112), horizontalTitleGap: 10),
  );
}

String getCurrentDate() {
  return DateFormat('EEEE, d MMM').format(DateTime.now());
}

String getCurrenthour() {
  return DateFormat('h:mm a').format(DateTime.now());
}

String getTimeFromUnix(int dt) {
  return DateFormat('h:mm a').format(
    DateTime.fromMillisecondsSinceEpoch(dt * 1000),
  );
}
