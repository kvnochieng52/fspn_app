import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

CurvedNavigationBar navigationBar(_bottomNavigationKey, _page, context) {
  return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.perm_identity, size: 30),
        Icon(Icons.supervised_user_circle, size: 30),
        Icon(Icons.compare_arrows, size: 30),
        Icon(Icons.call_split, size: 30),
        Icon(Icons.settings, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.green,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        _page = index;

        print(index);
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/farmers');
            break;
          case 1:
            Navigator.of(context).pushNamed('/groups');
            break;
          case 2:
            Navigator.of(context).pushNamed('/dashboard');
            break;
          case 3:
            Navigator.of(context).pushNamed('/farm_inputs');
            break;
          case 4:
            Navigator.of(context).pushNamed('/profile');
            break;
        }
      });
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
