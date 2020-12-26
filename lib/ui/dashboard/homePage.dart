import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Column buildcounColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
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
      padding: EdgeInsets.all(15),
      child: ListView(
        children: <Widget>[
          GridView(
            shrinkWrap: true,
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
          Padding(padding: EdgeInsets.only(top: 70.0)),
          Card(
            color: Colors.green,
            child: Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildcounColumn("Farmers", 100),
                        buildcounColumn("Groups", 500),
                        buildcounColumn("Organizations", 80),
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
                ),
              ),
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
