import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final _capacityController = TextEditingController();
  final _productionAreaController = TextEditingController();
  final _notesController = TextEditingController();

  int _farmerProduce;
  int _farmerSubProduce;
  int _selectedUnit;
  bool _initDataFetched = false;
  bool _isLoading = false;

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

  _getSubProduce(produceid) async {
    setState(() {
      _subProduces = List();
      _farmerSubProduce = null;
    });
    var res = await CallApi()
        .getData("farmer_produce/sub_produce/" + produceid.toString());
    var body = json.decode(res.body);

    setState(() {
      _subProduces = body['sub_produce'];
    });
  }

  _addProduce() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Loading().loader(context, "Adding Produce...Please wait");

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));
    var data = {
      'farmer_id': widget.data['farmer_id'],
      'produce_id': _farmerProduce,
      'sub_produce_id': _farmerSubProduce,
      'capacity': _capacityController.text,
      'unit': _selectedUnit,
      'production_area': _productionAreaController.text,
      'description': _notesController.text,
      'created_by': user['id'],
    };

    var res = await CallApi().postData(data, 'farmer_produce/add');
    var body = json.decode(res.body);

    if (body['success']) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(
        '/show_farmer',
        arguments: {"farmer_id": "${widget.data['farmer_id']}"},
      );
    } else {
      _showMsg(body['message']);
    }

    //Navigator.pop(context);
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
                      "Enter Farm Produce Details",
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
                          items: _produces.map((prod) {
                            return DropdownMenuItem(
                              value: prod['id'],
                              child: Text(prod['produce_name']),
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
                          items: _subProduces.map((subprod) {
                            return DropdownMenuItem(
                              value: subprod['id'],
                              child:
                                  Text("${subprod['produce_sub_type_name']}"),
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
                          controller: _capacityController,
                          decoration: InputDecoration(
                            labelText: 'Production Capacity',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            _capacityController.text = value;
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
                          value: _selectedUnit,
                          isExpanded: true,
                          hint: Text("Measurement Unit"),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedUnit = value;
                            });
                          },
                          items: _units.map((unt) {
                            return DropdownMenuItem(
                              value: unt['id'],
                              child: Text("${unt['unit_name']}"),
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
                          controller: _productionAreaController,
                          decoration: InputDecoration(
                            labelText: 'Production Area in Acre',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            _productionAreaController.text = value;
                          },
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
                          controller: _notesController,
                          decoration: InputDecoration(
                            labelText: 'Any Additional Notes',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          onSaved: (String value) {
                            _notesController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: _isLoading ? null : _addProduce,
                    disabledColor: Colors.lightGreen,
                    child: Text(
                      'SUBMIT',
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ),
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
