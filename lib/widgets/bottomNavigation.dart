import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

CurvedNavigationBar navigationBar(_bottomNavigationKey, _page) {
  return CurvedNavigationBar(
    key: _bottomNavigationKey,
    index: 0,
    height: 50.0,
    items: <Widget>[
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.compare_arrows, size: 30),
      Icon(Icons.call_split, size: 30),
      Icon(Icons.perm_identity, size: 30),
    ],
    color: Colors.white,
    buttonBackgroundColor: Colors.white,
    backgroundColor: Colors.green,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 600),
    onTap: (index) {
      _page = index;
      // setState(() {
      //   _page = index;
      // });
    },
  );
}

//   bottomNavigationBar: BottomNavigationBar(
//       currentIndex: _currentIndex,
//       type: BottomNavigationBarType.fixed,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.home), title: Text("Home")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.book), title: Text("Bookings")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.account_box), title: Text("Acoount")),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.more), title: Text("More")),
//       ]),

// );
