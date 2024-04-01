import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movieapp/config/app_theme/app_theme.dart';
import 'package:movieapp/core/screens/movie_details/movie_details.dart';
import 'package:movieapp/core/widgets/browse_widget/browse_widget_list.dart';
import 'package:movieapp/layout/home_layout.dart';

// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
  const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeData,
      themeMode: ThemeMode.dark,
        initialRoute: HomeLayout.routeName,
        routes: {
          HomeLayout.routeName: (context) => HomeLayout(),
          BrowseListWidget.routeName: (context) => BrowseListWidget(),
          MovieDetails.routeName: (context) => MovieDetails(),
        }
    );
  }
}
