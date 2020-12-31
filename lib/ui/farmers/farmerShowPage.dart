import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';

class FarmerShowPage extends StatefulWidget {
  final data;
  const FarmerShowPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FarmerShowState();
  }
}

class _FarmerShowState extends State<FarmerShowPage> {
  bool farmerFetched = false;
  var _farmer;
  List _farmerProduceList = List();

  void initState() {
    super.initState();
    _getFarmer();
  }

  _getFarmer() async {
    var res = await CallApi()
        .getData('farmer/get_farmer_by_id/' + widget.data['farmer_id']);

    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _farmer = body['farmer'];
        _farmerProduceList = body['farmer_produces'];
        farmerFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Farmer Details'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: farmerFetched ? _buildFarmerDetails(context) : circularProgress(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: farmerFetched
            ? () => Navigator.of(context).pushNamed('/edit_farmer',
                arguments: {"farmer_id": "${widget.data['farmer_id']}"})
            : null,
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.add),
      //   label: Text("New Farmer"),
      //   onPressed: () => print('hello'),
      // ),
    );
  }

  Widget _buildFarmerDetails(context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildBasicDetails(),
          _buidAdditionalDetails(),
          _buildFarmProduce(context),
        ],
      ),
    );
  }

  Widget _buildFarmProduce(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 2.5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Farmers Production",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.blue,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      "NEW PRODUCE",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/add_farmer_produce',
                      arguments: {"farmer_id": "${widget.data['farmer_id']}"},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _farmerProduceList.length,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    child: Text('Hello'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 2.5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "${_farmer['first_name'][0]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 30.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  "${_farmer['first_name']} ${_farmer['last_name']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  '${_farmer['address']}, ${_farmer['county_name']}, ${_farmer['sub_county_name']}',
                ),
                trailing: Column(
                  //spacing: 12, // space between two icons
                  children: <Widget>[
                    Text(
                      "${_farmer['id']}",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // ButtonBar(
              //   children: <Widget>[
              //     FlatButton(
              //       child: const Text('BUY TICKETS'),
              //       onPressed: () {/* ... */},
              //     ),
              //     FlatButton(
              //       child: const Text('LISTEN'),
              //       onPressed: () {/* ... */},
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buidAdditionalDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.fingerprint),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ID/Passport No.",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['id_passport']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.settings),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Farmer Production",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Crop",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Telephone",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['phone1']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.email),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['email']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Gender",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['gender_name']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Date Of Birth",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['date_of_birth']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.landscape),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Land Size",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${_farmer['land_size']} Acres",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
