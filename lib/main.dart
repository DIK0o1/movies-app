import 'package:flutter/material.dart';
import 'package:movieapp/layout/home_layout.dart';

import 'config/app_theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:AppTheme.appThemeData,
      themeMode: ThemeMode.dark,
        initialRoute: HomeLayout.routeName,
        routes: {
          HomeLayout.routeName: (context) => HomeLayout(),
        }
    );
  }
}


