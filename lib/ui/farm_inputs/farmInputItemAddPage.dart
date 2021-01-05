import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/loading.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmInputItemAddPage extends StatefulWidget {
  final data;

  const FarmInputItemAddPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FarmInputItemAddState();
  }
}

class _FarmInputItemAddState extends State<FarmInputItemAddPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _initDataFetched = false;
  bool _isLoading = false;

  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  List _inputs = List();
  List _subInputs = List();
  List _units = List();

  var _farmerInput;

  int _input;
  int _unit;
  int _subInput;

  _getInitDetails() async {
    var res = await CallApi().getData(
        "farm_input/add_farm_input_init?farmer_input_id=${widget.data['farmer_input_id']}");
    var body = json.decode(res.body);
    if (body['success']) {
      setState(() {
        _initDataFetched = true;
        _inputs = body['inputs'];
        _units = body['units'];
        _farmerInput = body['farmer_input'];
      });
    }
  }

  _getSubInputs(value) async {
    setState(() {
      _subInputs = List();
      _subInput = null;
    });

    var res =
        await CallApi().getData("farm_input/get_sub_input_data?input=$value");
    var body = json.decode(res.body);
    if (body['success']) {
      setState(() {
        _subInputs = body['sub_inputs'];
      });
    }
  }

  _addInputItem() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Loading().loader(context, "Creating Group...Please wait");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));
    var data = {
      'farmer_id': _farmerInput['farmer_id'],
      'farmer_input_id': widget.data['farmer_input_id'],
      'input_id': _input,
      'sub_input_id': _subInput,
      'quantity': _quantityController.text,
      'unit_id': _unit,
      'description': _descriptionController.text,
      'created_by': user['id'],
    };

    var res = await CallApi().postData(data, 'farm_input/add_farm_input_item');
    var body = json.decode(res.body);

    if (body['success']) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(
        '/farm_input_show',
        arguments: {"farmer_input_id": "${widget.data['farmer_input_id']}"},
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInitDetails();
  }

  Widget _buildAddInputForm(context) {
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
                      "Enter Farm Input Item Details",
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
                          value: _input,
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Select Farm Input' : null,
                          hint: Text(
                            "Select Farm Input",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            _getSubInputs(value);
                            setState(() {
                              _input = value;
                            });
                          },
                          items: _inputs.map((inp) {
                            return DropdownMenuItem(
                              value: inp['id'],
                              child: Text(
                                inp['input_name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
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
                          value: _subInput,
                          isExpanded: true,
                          hint: Text(
                            "Select Sub Input(Optional)",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _subInput = value;
                            });
                          },
                          items: _subInputs.map((county) {
                            return DropdownMenuItem(
                              value: county['id'],
                              child: Text(
                                county['sub_input_name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
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
                          keyboardType: TextInputType.number,
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'Enter Required Quantity',
                            labelStyle: TextStyle(fontSize: 16.0),
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter  Required Quantity' : null,
                          onSaved: (String value) {
                            _quantityController.text = value;
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
                          value: _unit,
                          isExpanded: true,
                          hint: Text(
                            "Select Measurement Unit",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          style: TextStyle(color: Colors.green),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _unit = value;
                            });
                          },
                          items: _units.map((uni) {
                            return DropdownMenuItem(
                              value: uni['id'],
                              child: Text(
                                uni['unit_name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
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
                    onPressed: _isLoading ? null : _addInputItem,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return (Text("${widget.data['farmer_input_id']}"));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add New Farm Input Item',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      // drawer: drawer(context),
      //   body: _buildFarmInputForm(context)
      body: _initDataFetched ? _buildAddInputForm(context) : circularProgress(),
    );
  }
}
