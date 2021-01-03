import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupShowPage extends StatefulWidget {
  final data;

  const GroupShowPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupShowState();
  }
}

class _GroupShowState extends State<GroupShowPage> {
  var _group;
  List _groupMembers = List();
  bool _groupDetailsFetched = false;

  _getGroupDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi().getData(
        "group/group_details/${widget.data['group_id']}/${user['id'].toString()}");

    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _group = body['group'];
        _groupMembers = body['group_members'];
        _groupDetailsFetched = true;
      });
    }
  }

  Widget _buildBasicDetails(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 2.5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      "${_group['group_name'][0]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${_group['group_name']}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Group ID",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("GFSPN-${_group['id']}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "County/Town",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${_group['county_name']}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Sub County",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${_group['sub_county_name']}"),
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.green,
                            child: Text(
                              "Edit Group",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(
                              '/edit_group',
                              arguments: {
                                "group_id": "${widget.data['group_id']}"
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text(
                                "Delete Group",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () => {},
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 2.5),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Group Members",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 13.0,
                    child: Text(
                      "${_groupMembers.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupDetails(context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildBasicDetails(context),
          _buildDescription(context),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getGroupDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _groupDetailsFetched ? _group['group_name'] : "Loading...",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: _groupDetailsFetched
          ? _buildGroupDetails(context)
          : circularProgress(),
    );
  }
}
