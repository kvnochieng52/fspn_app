import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var services = [
    "FARMERS",
    "GROUPS",
    "CBO",
    "INPUTS",
    "Menu1",
    "Menu2",
    // "Wall Painting Services",
    // "Move In/Out Cleaning Services"
  ];

  var images = [
    "images/broom.png",
    "images/adornment.png",
    "images/vacuum.png",
    "images/offices.png",
    "images/window.png",
    "images/house.png",
    // "images/paint-roller.png",
    // "images/cleaner.png",
  ];

  Column buildcounColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Row(
                  //mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildcounColumn("Posts", 0),
                    buildcounColumn("Followers", 0),
                    buildcounColumn("Following", 0),
                  ],
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // buildProfileButton(),
                  ],
                )
              ],
            ))
        // child: GridView.builder(
        //     itemCount: services.length,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //         childAspectRatio: MediaQuery.of(context).size.width /
        //             (MediaQuery.of(context).size.height / 1.8)),
        //     itemBuilder: (BuildContext context, int index) {
        //       return Card(
        //         child: Column(
        //           children: <Widget>[
        //             SizedBox(
        //               height: 24,
        //             ),
        //             Image.asset(
        //               images[index],
        //               height: 35,
        //               width: 35,
        //             ),
        //             Padding(
        //               padding: EdgeInsets.all(20),
        //               child: Text(
        //                 services[index],
        //                 style: TextStyle(
        //                     fontSize: 10,
        //                     fontFamily: "Montserrat",
        //                     height: 1.2,
        //                     fontWeight: FontWeight.w600),
        //                 textAlign: TextAlign.center,
        //               ),
        //             )
        //           ],
        //         ),
        //       );
        //     }),
        );
  }
}
