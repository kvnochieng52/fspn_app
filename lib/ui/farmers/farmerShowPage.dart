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
  var farmer;
  bool farmerFetched = false;

  void initState() {
    super.initState();
    _getFarmer();
  }

  _getFarmer() async {
    var res = await CallApi()
        .getData('farmer/get_farmer_by_id/' + widget.data['farmer_id']);

    setState(() {
      farmer = json.decode(res.body);
      farmerFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Farmer Details'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: farmerFetched ? _buildFarmerDetails() : circularProgress(),
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

  Widget _buildFarmerDetails() {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 2.5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Card 1"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 2.5, 5.0, 2.5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Card 2"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
