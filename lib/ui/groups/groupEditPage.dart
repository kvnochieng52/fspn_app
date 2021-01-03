import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupEditPage extends StatefulWidget {
  final data;
  const GroupEditPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupEditState();
  }
}

class _GroupEditState extends State<GroupEditPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _groupNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _initDataFetched = false;
  bool _isLoading = false;

  int _county;
  int _subCounty;

  List _counties = List();
  List _subcounties = List();

  var _group;

  void initState() {
    super.initState();
    _getInitData();
  }

  _getInitData() async {
    var res = await CallApi()
        .getData('group/init_edit_data/' + widget.data['group_id']);

    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _counties = body['counties'];
        _group = body['group'];

        _groupNameController.text = _group['group_name'];
        _county = _group['county'];

        _subcounties = [
          {
            "id": _group['sub_county'],
            "sub_county_name": _group['sub_county_name']
          }
        ];
        _subCounty = _group['sub_county'];
        _descriptionController.text = _group['description'];

        _initDataFetched = true;
      });
    }
  }

  _getSubCounties(county) async {
    setState(() {
      _subcounties = List();
      _subCounty = null;
    });
    var res = await CallApi().getData("sub_counties/" + county.toString());

    setState(() {
      _subcounties = List();
      _subcounties = json.decode(res.body);
    });
  }

  _updateGroup() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Loading().loader(context, "Updating Group...Please wait");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));
    var data = {
      'group_id': widget.data['group_id'],
      'group_name': _groupNameController.text,
      'county': _county,
      'sub_county': _subCounty,
      'description': _descriptionController.text,
      'created_by': user['id'],
    };

    var res = await CallApi().postData(data, 'group/update');
    var body = json.decode(res.body);

    if (body['success']) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(
        '/show_group',
        arguments: {"group_id": "${body['group_id']}"},
      );
    }
  }

  Widget _buildAddFarmerProduceForm(context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Form(
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
                      "Enter Group Details",
                      style: TextStyle(
                        fontSize: 17.0,
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
                          controller: _groupNameController,
                          decoration: InputDecoration(
                            labelText: 'Group Name',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Group Name' : null,
                          onSaved: (String value) {
                            _groupNameController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: DropdownButtonFormField(
                          value: _county,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Select County' : null,
                          hint: Text("Select County"),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            _getSubCounties(value);
                            setState(() {
                              _county = value;
                            });
                          },
                          items: _counties.map((county) {
                            return DropdownMenuItem(
                              value: county['id'],
                              child: Text(county['county_name']),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: DropdownButtonFormField(
                          value: _subCounty,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Select Sub County' : null,
                          hint: Text("Select Sub County"),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _subCounty = value;
                            });
                          },
                          items: _subcounties.map((county) {
                            return DropdownMenuItem(
                              value: county['id'],
                              child: Text(county['sub_county_name']),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description(optional)',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          onSaved: (String value) {
                            _descriptionController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: _isLoading ? null : _updateGroup,
                    disabledColor: Colors.lightGreen,
                    child: Text(
                      'UPDATE',
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
          'Edit Group',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      // drawer: drawer(context),
      body: _initDataFetched
          ? _buildAddFarmerProduceForm(context)
          : circularProgress(),
    );
  }
}
