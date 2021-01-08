import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/bottomNavigation.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'homePage.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashboardPage> {
  //var _currentIndex = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  var _farmerCount = 0;
  var _groupCount = 0;
  var _orgCount = 0;
  bool _statsFetched = false;
  var _user;
  var _userFetched = false;

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
  void initState() {
    super.initState();
    _getStats();
  }

  _getStats() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi()
        .getData('dashboard_stats?user_id=' + user['id'].toString());

    var body = json.decode(res.body);

    setState(() {
      _user = json.decode(localStorage.getString('user'));
      _userFetched = true;
    });

    if (body['success']) {
      setState(() {
        _farmerCount = body['farmers_count'];
        _groupCount = body['group_count'];
        _orgCount = body['org_count'];
        _statsFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Dashboard'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: _buildBodyptions(context),
      bottomNavigationBar: navigationBar(_bottomNavigationKey, _page, context),
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
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.8)
                : MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.1)),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(options[index][2]),
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    options[index][1],
                    height: 50,
                    width: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      options[index][0].toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
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
      ),
    );
  }

  Widget _buildBodyptions(context) {
    return
        // padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
        ListView(
      children: <Widget>[
        _buildTopStrip(),
        _buildIcons(context),
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 70.0, 5.0, 5.0),
          child: _statsFetched
              ? Card(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          //mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buidStatsOptions("Farmers", _farmerCount),
                            _buidStatsOptions("Groups", _groupCount),
                            _buidStatsOptions("Organizations", _orgCount),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : circularProgress(),
        ),
      ],
    );
  }

  Widget _buildTopStrip() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _userFetched
                        ? "Welcome Back ${_user['name']}."
                        : "Loading your Details...",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.verified_user,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
