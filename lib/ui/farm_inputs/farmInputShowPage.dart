import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/progress.dart';

class FarmerInputShowPage extends StatefulWidget {
  final data;
  const FarmerInputShowPage({Key key, @required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FarmerInputShowState();
  }
}

class _FarmerInputShowState extends State<FarmerInputShowPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _initDataFetched = false;

  var _farmer;
  List _currentInputItems = List();

  @override
  void initState() {
    super.initState();
    _getFarmerDetails();
  }

  _getFarmerDetails() async {
    var res = await CallApi().getData(
        "farm_input/get_init_details?farm_input_id=${widget.data['farmer_input_id']}");
    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _farmer = body['farmer'];
        _currentInputItems = body['current_farmer_inputs_items'];
        _initDataFetched = true;
      });
    }
  }

  _deleteFarmInputItem(inputItem) async {
    var data = {
      'farm_input_item_id': inputItem,
      'farm_input_id': widget.data['farmer_input_id'],
    };
    var res =
        await CallApi().postData(data, 'farm_input/delete_farm_input_item');
    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _currentInputItems = body['current_farmer_inputs_items'];
      });
      _showMsg('Farm Input Item Deleted Successfully');
    } else {
      _showMsg('Someting went wrong... Please try later.');
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget _buildFarmInputView(context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildBasicDetails(context),
          _buildFarmInputsDetails(),
        ],
      ),
    );
  }

  Widget _buildBasicDetails(context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: mediaQuery.size.width,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Farmer Details",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Full Names",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${_farmer['first_name']} ${_farmer['last_name']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 3,
                  thickness: 1,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Account Number",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${_farmer['id']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 3,
                  thickness: 1,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "County",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${_farmer['county_name']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 3,
                  thickness: 1,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Sub County",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${_farmer['sub_county_name']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 3,
                  thickness: 1,
                  endIndent: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Telephone",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${_farmer['phone1']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 3,
                  thickness: 1,
                  endIndent: 0,
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildFarmInputsDetails() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Farm Inputs",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/farm_input_item_add',
                        arguments: {
                          "farmer_input_id": widget.data['farmer_input_id']
                        },
                      );
                    },
                    child: Text(
                      "Add Farm Input Item",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ],
              ),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _currentInputItems.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              _currentInputItems[position]['sub_input_name'] !=
                                      null
                                  ? "${_currentInputItems[position]['input_name']} / ${_currentInputItems[position]['sub_input_name']}"
                                  : "${_currentInputItems[position]['input_name']}",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _currentInputItems[position]['unit_name'] !=
                                          null
                                      ? "Quantity :${_currentInputItems[position]['quantity']} ${_currentInputItems[position]['unit_name']}"
                                      : "Quantity :${_currentInputItems[position]['quantity']}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _currentInputItems[position]
                                                ['farm_input_desc'] !=
                                            null
                                        ? _currentInputItems[position]
                                            ['farm_input_desc']
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Farm Input Item'),
                                      content: Text(
                                          'Are you sure you want to delete?'),
                                      actions: <Widget>[
                                        RaisedButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            _deleteFarmInputItem(
                                                _currentInputItems[position]
                                                    ['farmer_input_item_id']);
                                          },
                                          child: Text('Delete'),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Farm inputs',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      drawer: drawer(context),
      body:
          _initDataFetched ? _buildFarmInputView(context) : circularProgress(),
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
