import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  String _email;
  String _password;

  bool _isLoading = false;
  ScaffoldState scaffoldState;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _buildEmailField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'Email Address',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
        ),
        validator: (String value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
          if (!emailValid) {
            return "Enter a Valid Email";
          }
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 15, color: Colors.white),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Please Enter your Password";
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/start_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'images/logo.png',
                  width: 150,
                  height: 150,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailField(),
                      _buildPasswordField(),
                      //linearProgress(),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          'Forgot your password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              //fontFamily: 'SFUIDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: _isLoading ? null : _loginUser,
                          disabledColor: Colors.lightGreen,
                          child: Text(
                            _isLoading ? 'LOGGING IN...PLEASE WAIT' : 'LOGIN',
                            style: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          //color: Color(0xffff2d55),
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          minWidth: 350,
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Need help to get started?",
                            style: TextStyle(
                              //fontFamily: 'SFUIDisplay',
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        TextSpan(
                            text: " contact us",
                            style: TextStyle(
                              // fontFamily: 'SFUIDisplay',
                              //color: Configuration.yellowColor,
                              fontSize: 15,
                            ))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginUser() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    var data = {'email': _email, 'password': _password};
    var res = await CallApi().postData(data, 'login');

    var body = json.decode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.of(context).pushNamed('/dashboard');
    } else {
      _showMsg(body['message']);
    }

    print(body);

    setState(() {
      _isLoading = false;
    });
  }
}
