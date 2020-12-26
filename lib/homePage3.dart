import 'package:flutter/material.dart';

class HomePage3 extends StatelessWidget {
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
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.7),
        ),
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/farmer.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'FARMERS',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/chat-group.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'GROUPS',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/seedling.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'FARM INPUTS',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/organization.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'ORGANIZATIONS',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/profile.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'PROFILE',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/profile.png',
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'PROFILE',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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

      // child: Expanded(
      //     flex: 1,
      //     child: Column(
      //       children: <Widget>[
      //         Row(
      //           //mainAxisSize: MainAxisSize.max,
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: <Widget>[
      //             buildcounColumn("Posts", 0),
      //             buildcounColumn("Followers", 0),
      //             buildcounColumn("Following", 0),
      //           ],
      //         ),
      //         Row(
      //           // mainAxisSize: MainAxisSize.max,
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: <Widget>[
      //             // buildProfileButton(),
      //           ],
      //         )
      //       ],
      //     ))
    );
  }
}
