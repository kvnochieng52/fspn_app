import 'package:flutter/material.dart';
import 'package:fspn/widgets/bottomNavigation.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';

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

  var options = [
    [
      "Farmers",
      "images/farmer.png",
      "/farmers",
    ],
    [
      "Groups",
      "images/chat-group.png",
      "/groups",
    ],
    [
      "Farm Inputs",
      "images/seedling.png",
      "/farm_inputs",
    ],
    [
      "Organizations",
      "images/organization.png",
      "/organizations",
    ],
    [
      "Profile",
      "images/profile.png",
      "/profile",
    ],
    [
      "Logout",
      "images/logout.png",
      "/logout",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Dashboard'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: _buildBodyptions(context),
      bottomNavigationBar: navigationBar(_bottomNavigationKey, _page),
    );
  }

  Column _buidStatsOptions(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcons(context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.7)),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(options[index][2]),
          child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  options[index][1],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    options[index][0],
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyptions(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
      child: ListView(
        children: <Widget>[
          _buildIcons(context),
          Padding(padding: EdgeInsets.only(top: 70.0)),
          Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buidStatsOptions("Farmers", 100),
                      _buidStatsOptions("Groups", 500),
                      _buidStatsOptions("Organizations", 80),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
