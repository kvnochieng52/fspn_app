import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:my_zuku/route_generator.dart';
// import 'package:my_zuku/models/configuration.dart';
// import 'package:my_zuku/ui/dashboard.dart';
// import 'package:my_zuku/ui/register.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
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
                  height: 100,
                ),
                Image.asset(
                  'images/logo.png',
                  width: 150,
                  height: 150,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Username',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      )
                    ],
                  ),
                ),
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
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/dashboard');
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 15,
                          // fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.userCog),
                        Text(
                          'I want to Register my Account',
                          style: TextStyle(
                            fontSize: 15,
                            //fontFamily: 'SFUIDisplay',
                          ),
                        )
                      ],
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    minWidth: 350,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white)),
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
}
