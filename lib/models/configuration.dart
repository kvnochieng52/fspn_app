//import 'package:flutter/material.dart';

class Configuration {
  static const appName = 'FSPN-AFRICA';
  static const imagesPath = './images';
  static const appLogo = "$imagesPath/logo.png";
  static const API_URL = 'http://10.0.2.2:8000/api/';

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
