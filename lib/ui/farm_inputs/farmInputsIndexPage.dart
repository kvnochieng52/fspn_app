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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _detailsFetched = false;
  List _farmInputs = List();

  @override
  void initState() {
    super.initState();
    _getFarmeInputs();
  }

  _getFarmeInputs() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi()
        .getData('farm_input/get_farm_inputs?user_id=' + user['id'].toString());
    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _farmInputs = body['farmer_inputs'];
        _detailsFetched = true;
      });
    }
  }

  _deleteFarmInput(farmInput) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var data = {
      'farm_input': farmInput,
      'user_id': user['id'],
    };
    var res = await CallApi().postData(data, 'farm_input/delete_farm_input');
    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _farmInputs = body['farmer_inputs'];
      });
      _showMsg('Farm Input  Deleted Successfully');
    } else {
      _showMsg('Someting went wrong... Please try later.');
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget _buildFarmInputsList() {
    return ListView(
      children: <Widget>[
        // _buildTopStrip(),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _farmInputs.length,
          padding: const EdgeInsets.all(8.5),
          itemBuilder: (BuildContext context, int position) {
            return Card(
              child: Column(
                children: <Widget>[
                  Divider(height: 5.5),
                  ListTile(
                    title: Text(
                      "${_farmInputs[position]['first_name']} ${_farmInputs[position]['last_name']}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2.0,
                            top: 2.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Account No: ${_farmInputs[position]['id']}",
                              style: TextStyle(
                                fontSize: 13.9,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2.0,
                            top: 2.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${_farmInputs[position]['county_name']}, ${_farmInputs[position]['sub_county_name']}",
                              style: TextStyle(
                                fontSize: 13.9,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),

                        Row(
                          children: <Widget>[
                            Text("Status: "),
                            Text(
                              "${_farmInputs[position]['status_name']}",
                              style: TextStyle(
                                color: _farmInputs[position]['status_name'] ==
                                        'Pending'
                                    ? Colors.orange
                                    : Colors.green,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "${_farmInputs[position]['county_name']}, ${_farmInputs[position]['sub_county_name']}",
                        //     style: TextStyle(
                        //       fontSize: 13.9,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        "${_farmInputs[position]['first_name'][0]}"
                            .toUpperCase(),
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
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete Farm Input Item'),
                                content:
                                    Text('Are you sure you want to delete?'),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      _deleteFarmInput(_farmInputs[position]
                                          ['farm_input_id']);
                                    },
                                    child: Text('Delete'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // icon-1
                        //Icon(Icons.chevron_right), // icon-2
                      ],
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                      '/farm_input_show',
                      arguments: {
                        "farmer_input_id":
                            "${_farmInputs[position]['farm_input_id']}"
                      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: 'Farm Inputs'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: Container(
        child: _detailsFetched ? _buildFarmInputsList() : circularProgress(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/new_farm_input'),
      ),
    );
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
