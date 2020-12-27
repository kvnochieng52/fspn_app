import 'package:flutter/material.dart';

// AppBar header(context, {bool isAppTitle = false, String titleText}) {
//   return AppBar(
//     title: Text(
//       isAppTitle ? "FlutterShare" : titleText,
//       style: TextStyle(
//         color: Colors.white,
//         fontFamily: isAppTitle ? "Signatra" : "",
//         fontSize: isAppTitle ? 50.0 : 20.0,
//       ),
//     ),
//     centerTitle: true,
//     backgroundColor: Theme.of(context).accentColor,
//     leading: IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () => Navigator.pop(context, false),
//     ),
//     automaticallyImplyLeading: false,
//   );
// }

AppBar header(context, {String titleText}) {
  return AppBar(
    centerTitle: true,
    title: Row(
      children: <Widget>[
        Image.asset(
          'images/logo.png',
          fit: BoxFit.cover,
          height: 50.0,
          width: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            titleText.isEmpty ? "Dashboard" : titleText,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
    elevation: 0.0,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.more_vert),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {},
      ),
    ],
  );
}
