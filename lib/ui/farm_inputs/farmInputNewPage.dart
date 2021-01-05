import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmInputNewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FarmInputNewState();
  }
}

class _FarmInputNewState extends State<FarmInputNewPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchController = TextEditingController();

  bool _isLoading = false;
  bool _farmerFound = false;

  var _farmer;

  _searchFarmer() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Loading().loader(context, "Searching Farmer...Please wait");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi().getData(
        "farm_input/search_farmer/${_searchController.text}/${user['id'].toString()}");
    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _farmer = body['farmer'];
        _farmerFound = true;
      });
    } else {
      _showMsg(body['message']);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  _continueFarmInput() async {
    Loading().loader(context, "Searching Farmer...Please wait");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));
    var data = {
      'farmer_id': _farmer['id'],
      'created_by': user['id'],
    };

    var res = await CallApi().postData(data, 'farm_input/add');
    var body = json.decode(res.body);

    if (body['success']) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(
        '/farm_input_show',
        arguments: {"farmer_input_id": "${_farmer['id']}"},
      );
    }
  }

  Widget _buildFarmInputForm(context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: _farmerFound
            ? _buildContinueRegistration(mediaQuery)
            : _buildSearchForm(mediaQuery),
      ),
    );
  }

  Widget _buildContinueRegistration(mediaQuery) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: mediaQuery.size.width,
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Farmer Found. Please Click continue to proceed",
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
            color: Colors.grey,
            height: 5,
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
            color: Colors.grey,
            height: 5,
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
            color: Colors.grey,
            height: 5,
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
            color: Colors.grey,
            height: 5,
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
            color: Colors.grey,
            height: 5,
            thickness: 1,
            endIndent: 0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              child: Text(
                "CONTINUE",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _continueFarmInput(),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchForm(mediaQuery) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: mediaQuery.size.width,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter Farmers Account No or ID Number or Telephone No",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Enter Search Value',
                        labelStyle: TextStyle(fontSize: 16.0),
                        isDense: true,
                        contentPadding: EdgeInsets.all(5),
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Search Value' : null,
                      onSaved: (String value) {
                        _searchController.text = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: MaterialButton(
                onPressed: _isLoading ? null : _searchFarmer,
                disabledColor: Colors.lightGreen,
                child: Text(
                  'SEARCH FARMER',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //color: Color(0xffff2d55),
                color: Theme.of(context).primaryColor,
                elevation: 0,
                minWidth: 350,
                height: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Add New Farm Input',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        // drawer: drawer(context),
        body: _buildFarmInputForm(context)
        //  _initDataFetched ? _buildFarmInputForm(context) : circularProgress(),
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
