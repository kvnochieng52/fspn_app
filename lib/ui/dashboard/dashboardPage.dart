import 'package:flutter/material.dart';
import 'package:fspn/widgets/bottomNavigation.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/ui/dashboard/homePage.dart';
//import 'homePage.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashboardPage> {
  var _currentIndex = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Dashboard'),
      drawer: drawer(),
      backgroundColor: Color(0xFFF0F0F0),
      body: getBodyWidget(),
      bottomNavigationBar: navigationBar(_bottomNavigationKey, _page),
    );
  }

  getBodyWidget() {
    //return (_currentIndex == 0) ? HomePage() : Container();

    return HomePage();
  }
}
