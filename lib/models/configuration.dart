//import 'package:flutter/material.dart';

class Configuration {
  static const appName = 'FSPN-AFRICA';
  static const imagesPath = './images';
  static const appLogo = "$imagesPath/logo.png";
  static const API_URL = 'http://ims.fspnafrica.org/api/';
  static const WEB_URL = 'http://ims.fspnafrica.org/';

  // static validateEmail(String email) {
  //   return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
  //       .hasMatch(email);
  // }

  static validateEmail(String email) async {
    // bool emailValid = RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(email);
    // return emailValid;

    return "name";
  }
}
