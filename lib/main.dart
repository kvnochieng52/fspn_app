import 'package:flutter/material.dart';
import 'package:fspn/models/configuration.dart';
import 'package:fspn/route_generator.dart';
import 'package:flutter/cupertino.dart';

//import 'mainPage.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
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
