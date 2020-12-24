import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  var _currentIndex = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // const curveHeight = 50.0;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Hygiene Homes"),
        //   // shape: const MyShapeBorder(curveHeight),
        // ),

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
          title: Text(
            'Chats',
            style: TextStyle(
              //fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Color(0xFFF0F0F0),
        body: getBodyWidget(),
        bottomNavigationBar: CurvedNavigationBar(
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
            setState(() {
              _page = index;
            });
          },
        ));
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
  }

  getBodyWidget() {
    return (_currentIndex == 0) ? HomePage() : Container();
  }
}

// class MyShapeBorder extends ContinuousRectangleBorder {
//   const MyShapeBorder(this.curveHeight);
//   final double curveHeight;

//   @override
//   Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
//     ..lineTo(0, rect.size.height)
//     ..quadraticBezierTo(
//       rect.size.width / 2,
//       rect.size.height + curveHeight * 2,
//       rect.size.width,
//       rect.size.height,
//     )
//     ..lineTo(rect.size.width, 0)
//     ..close();
// }
