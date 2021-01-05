import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfilePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _profileDetailsFetched = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      _nameController.text = _user['name'];
      _emailController.text = _user['email'];
      _profileDetailsFetched = true;
    });
  }

  _updateProfile() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    Loading().loader(context, "Updating Profile...Please wait");

    var data = {
      'user_id': _user['id'],
      'password': _passwordController.text,
    };

    var res = await CallApi().postData(data, 'user/update_profile');
    var body = json.decode(res.body);

    if (body['success']) {
      Navigator.pop(context);
      _showMsg("Profile Updated Successfully");
    }
  }

  Widget _buildProfileForm(context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: mediaQuery.size.width,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: _nameController,
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Your Name' : null,
                          onSaved: (String value) {
                            _nameController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: _emailController,
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            labelText: 'Your Email',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          validator: (value) => value.isEmpty ? 'Email' : null,
                          onSaved: (String value) {
                            _emailController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Reset Password',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          validator: (value) => value.length < 7
                              ? 'Enter Valid Password... Password must be six characters and more'
                              : null,
                          onSaved: (String value) {
                            _passwordController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          "UPDATE PROFILE",
                          style: TextStyle(fontSize: 17.0, color: Colors.white),
                        ),
                        onPressed: () => _updateProfile(),
                      ),
                      RaisedButton(
                        color: Colors.red,
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(fontSize: 17.0, color: Colors.white),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/logout'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: 'Update Profile'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: _profileDetailsFetched
          ? _buildProfileForm(context)
          : circularProgress(),
    );
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
