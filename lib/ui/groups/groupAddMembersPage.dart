import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupAddMembersPage extends StatefulWidget {
  final data;
  const GroupAddMembersPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupAddMembersState();
  }
}

class _GroupAddMembersState extends State<GroupAddMembersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _groupDetailsFetched = false;
  var _group;
  List farmers = List();

  _getGroupDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi().getData(
        "group/group_details/${widget.data['group_id']}/${user['id'].toString()}");

    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _group = body['group'];
        farmers = body['farmers'];
        _groupDetailsFetched = true;
      });
    }
  }

  _addMemberToGroup(farmerID) {
    Loading().loader(context, "Adding Member...Please wait");
  }

  @override
  void initState() {
    super.initState();
    _getGroupDetails();
  }

  _buildGroupFarmersList(context) {
    return ListView(
      children: <Widget>[
        _buildSearchField(),
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
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            //Text("Account No: ${farmers[position]['id']}"),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${farmers[position]['county_name']}, ${farmers[position]['sub_county_name']}",
                                style: TextStyle(
                                  fontSize: 13.9,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),

                        FlatButton(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              Text(
                                ' Add',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _addMemberToGroup(farmers[position]['id']);
                          },
                        )
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.check_box),
                        //   color: Colors.green,
                        // )
                      ],
                    ),
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
                    // trailing: Column(
                    //   //spacing: 12, // space between two icons
                    //   children: <Widget>[
                    //     Text(
                    //       "${farmers[position]['id']}",
                    //       style: TextStyle(
                    //           fontSize: 15.0, fontWeight: FontWeight.bold),
                    //     ),
                    //     Icon(Icons.more_horiz), // icon-1
                    //     //Icon(Icons.chevron_right), // icon-2
                    //   ],
                    // ),
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

  Widget _buildSearchField() {
    return Text("Serach Field");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _groupDetailsFetched
              ? "Add Member to ${_group['group_name']}"
              : "Loading...",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: _groupDetailsFetched
          ? _buildGroupFarmersList(context)
          : circularProgress(),
    );
  }
}
