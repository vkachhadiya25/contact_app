import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme:  const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Colors.black,
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
  ),
  brightness: Brightness.light,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 25, color: Colors.white),
    titleMedium: TextStyle(fontSize: 20, color: Colors.white),
    titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.black,fontSize: 20),
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 25, color: Colors.white),
    titleMedium: TextStyle(fontSize: 20, color: Colors.white),
    titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  ),
);
