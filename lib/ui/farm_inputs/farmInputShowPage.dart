import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerInputShowPage extends StatefulWidget {
  final data;
  const FarmerInputShowPage({Key key, @required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FarmerInputShowState();
  }
}

class _FarmerInputShowState extends State<FarmerInputShowPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

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
          child: Text("Details"),
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
      //drawer: drawer(context),
      body:
          _initDataFetched ? _buildFarmInputView(context) : circularProgress(),
    );
  }
}
