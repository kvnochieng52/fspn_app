import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmersIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FarmersIndexState();
  }
}

class _FarmersIndexState extends State<FarmersIndexPage> {
  List farmers = List();
  bool farmersFetched = false;

  @override
  void initState() {
    super.initState();
    _getFarmers();
  }

  _getFarmers() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res =
        await CallApi().getData('farmer/get_farmers/' + user['id'].toString());

    setState(() {
      farmers = json.decode(res.body);
      farmersFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Farmers'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: Container(
        child: farmersFetched ? _buildFarmersList() : circularProgress(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/new_farmer'),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.add),
      //   label: Text("New Farmer"),
      //   onPressed: () => print('hello'),
      // ),
    );
  }

  Widget _buildFarmersList() {
    return ListView(
      children: <Widget>[
        _buildTopStrip(),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: farmers.length,
          padding: const EdgeInsets.all(8.5),
          itemBuilder: (BuildContext context, int position) {
            return Card(
              child: Column(
                children: <Widget>[
                  Divider(height: 5.5),
                  ListTile(
                    title: Text(
                      "${farmers[position]['first_name']} ${farmers[position]['last_name']}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    subtitle: Text(
                        "${farmers[position]['county_name']}, ${farmers[position]['sub_county_name']}",
                        style: TextStyle(
                            fontSize: 13.9,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic)),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        "${farmers[position]['first_name'][0]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Column(
                      //spacing: 12, // space between two icons
                      children: <Widget>[
                        Text(
                          "${farmers[position]['id']}",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.more_horiz), // icon-1
                        //Icon(Icons.chevron_right), // icon-2
                      ],
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                      '/show_farmer',
                      arguments: {"farmer_id": "${farmers[position]['id']}"},
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopStrip() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Registered Farmers",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 13.0,
              child: Text(
                farmers.length.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
