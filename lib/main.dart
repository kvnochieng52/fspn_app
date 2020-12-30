import 'package:flutter/material.dart';
import 'package:fspn/models/configuration.dart';
import 'package:fspn/route_generator.dart';
import 'package:flutter/cupertino.dart';
//import 'mainPage.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Configuration.appName,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'SFUIDisplayMedium',
      ),
      // home: MainPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
