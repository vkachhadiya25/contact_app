import 'package:calculater_app/provider/add_contact_provider.dart';
import 'package:calculater_app/provider/theme_provider.dart';
import 'package:calculater_app/utils/app_routes.dart';
import 'package:calculater_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: (context) => AddContactProvider(),),
       ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          value.themeData();
         return MaterialApp(
            theme: value.isLight?lightTheme:darkTheme,
            debugShowCheckedModeBanner: false,
            routes: screen_routes,
          );
        }
      ),
    )
  );
}


