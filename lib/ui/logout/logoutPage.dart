import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogOutState();
  }
}

class _LogOutState extends State<LogOutPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _profileDetailsFetched = false;

  var _user;

  @override
  void initState() {
    super.initState();
    _getProfileDetails();
  }

  _getProfileDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      _user = json.decode(localStorage.getString('user'));
      _profileDetailsFetched = true;
    });
  }

  _logoutUser() async {
    // logout from the server ...
    Loading().loader(context, "Updating Profile...Please wait");
    //var res = await CallApi().getData('logout');
    //var body = json.decode(res.body);

    // if (body['success']) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.pop(context);
    Navigator.of(context).pushNamed('/');
    // Navigator.pop(context);
    // }
  }

  Widget _buildLogoutButton(context) {
    //final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Hi ${_user['name']}, you are about log out to continue please Tap on  Logout",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              Center(
                  child: RaisedButton(
                color: Colors.red,
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => _logoutUser(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: 'Logout'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: _profileDetailsFetched
          ? _buildLogoutButton(context)
          : circularProgress(),
    );
  }
}
