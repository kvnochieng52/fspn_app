import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/progress.dart';

class FarmersAddProducePage extends StatefulWidget {
  final data;
  const FarmersAddProducePage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FarmersAddProduceState();
  }
}

class _FarmersAddProduceState extends State<FarmersAddProducePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _capacity = TextEditingController();
  final _productionArea = TextEditingController();
  final _notes = TextEditingController();
  int _farmerProduce;
  int _farmerSubProduce;
  int _selectedUnit;

  bool _initDataFetched = false;
  List _produces = List();
  List _subProduces = List();
  List _units = List();

  void initState() {
    super.initState();
    _getInitData();
  }

  void _getInitData() async {
    var res = await CallApi().getData('farmer_produce/init_data/');

    var body = json.decode(res.body);

    if (body['success']) {
      setState(() {
        _produces = body['produces'];
        _units = body['units'];
        _initDataFetched = true;
      });
    }
  }

  _getSubProduce(value) async {
    setState(() {
      _subProduces = List();
      _farmerSubProduce = null;
    });
    var res = await CallApi().getData("farmer_produce/sub_produce/" + value);

    setState(() {
      _subProduces = json.decode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Farmer Produce',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: _initDataFetched
          ? _buildAddFarmerProduceForm(context)
          : circularProgress(),
    );
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
                      "Enter the Farmers Details to Edit",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: DropdownButtonFormField(
                          value: _farmerProduce,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Select Produce' : null,
                          hint: Text("Select Produce"),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            _getSubProduce(value);
                            setState(() {
                              _farmerProduce = value;
                            });
                          },
                          items: _produces.map((country) {
                            return DropdownMenuItem(
                              value: country['id'],
                              child: Text(country['produce_name']),
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
                          value: _farmerSubProduce,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Select Sub Produce' : null,
                          hint: Text("Select Sub Produce"),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _farmerSubProduce = value;
                            });
                          },
                          items: _produces.map((country) {
                            return DropdownMenuItem(
                              value: country['id'],
                              child: Text(country['produce_name']),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
