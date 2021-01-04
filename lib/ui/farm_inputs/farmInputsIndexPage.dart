import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmInputsIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FarmInputsIndexState();
  }
}

class _FarmInputsIndexState extends State<FarmInputsIndexPage> {
  List groups = List();
  bool groupsFetched = false;

  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  _getGroups() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res =
        await CallApi().getData('group/get_groups/' + user['id'].toString());
    groups = json.decode(res.body);
    setState(() {
      groups = json.decode(res.body);
      groupsFetched = true;
    });
  }

  Widget _buildGroupsList() {
    return ListView(
      children: <Widget>[
        _buildTopStrip(),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: groups.length,
          padding: const EdgeInsets.all(8.5),
          itemBuilder: (BuildContext context, int position) {
            return Card(
              child: Column(
                children: <Widget>[
                  Divider(height: 5.5),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                      child: Text(
                        "${groups[position]['group_name']}",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${groups[position]['sub_county_name']}, ${groups[position]['county_name']}",
                            style: TextStyle(
                                fontSize: 13.9,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Description: ",
                                style: TextStyle(
                                  fontSize: 13.9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                groups[position]['description'] != null
                                    ? "${groups[position]['description']}"
                                    : '',
                                style: TextStyle(
                                  fontSize: 13.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        "${groups[position]['group_name'][0]}".toUpperCase(),
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
                          "GFSPN-${groups[position]['id']}",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 13.0,
                            child: Text(
                              "${groups[position]['members_count']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ), // icon-1
                        //Icon(Icons.chevron_right), // icon-2
                      ],
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                      '/show_group',
                      arguments: {"group_id": "${groups[position]['id']}"},
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
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Registered Groups",
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
                groups.length.toString(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Farm Inputs'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/new_farm_input'),
      ),
      body: Container(
          // child: groupsFetched ? _buildGroupsList() : circularProgress(),
          ),
    );
  }
}
