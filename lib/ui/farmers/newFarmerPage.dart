import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/ui/farmers/farmerShowPage.dart';
import 'package:fspn/ui/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewFarmerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewFarmerState();
  }
}

class _NewFarmerState extends State<NewFarmerPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool cropcheckedValue = false;
  bool livestockcheckedValue = false;
  bool _isLoading = false;

  String _first_name;
  String _last_name;
  String _id_number;
  String _email;
  String _phone_no;
  String _phone2;
  String _country;
  String _county;
  String _sub_county;
  String _address;
  String _dob;
  String _landsize;
  String _gender;

  List countries = List();
  List counties = List();
  List sub_counties = List();
  List genders = List();

  DateTime selectedDate = DateTime.now();

  get localStorage => null;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2090));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _registerFarmer() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Loading().loader(context, "Registering Farmer...Please wait");

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var data = {
      'first_name': _first_name,
      'last_name': _last_name,
      'id_passport': _id_number,
      'email': _email,
      'phone1': _phone_no,
      'phone2': _phone2,
      'country': _country,
      'town': _county,
      'sub_county': _sub_county,
      'land_size': _landsize,
      'gender': _gender,
      'crop': cropcheckedValue,
      'livestock': livestockcheckedValue,
      'address': _address,
      'date_of_birth': selectedDate.toString(),
      'created_by': user['id'],
    };

    var res = await CallApi().postData(data, 'farmer/create');
    var body = json.decode(res.body);

    print(body);

    if (body['success']) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed('/show_farmer');
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCountries();
    _getCounties();
    _getGender();
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
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future _getCountries() async {
    var res = await CallApi().getData('countries/');

    setState(() {
      countries = json.decode(res.body);
    });
  }

  Future _getCounties() async {
    var res = await CallApi().getData('counties/');

    setState(() {
      counties = json.decode(res.body);
    });
  }

  Future _getGender() async {
    var res = await CallApi().getData('gender/');
    setState(() {
      genders = json.decode(res.body);
    });
  }

  _getSubCounties(value) async {
    setState(() {
      sub_counties = List();
      _sub_county = null;
    });
    var res = await CallApi().getData("sub_counties/" + value);

    setState(() {
      sub_counties = json.decode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'New Farmer',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                          "Enter the Farmers Details to Register",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Firstname";
                              }
                            },
                            onSaved: (String value) {
                              _first_name = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Lastname";
                              }
                            },
                            onSaved: (String value) {
                              _last_name = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'ID/Passport No',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter ID or Passport";
                              }
                            },
                            onSaved: (String value) {
                              _id_number = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            validator: (String value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Enter a Valid Email";
                              }
                            },
                            onSaved: (String value) {
                              _email = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone No.',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Phone No.";
                              }
                            },
                            onSaved: (String value) {
                              _phone_no = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Alternate Phone No.',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            onSaved: (String value) {
                              _phone2 = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: DropdownButtonFormField(
                            value: _country,
                            isExpanded: true,
                            validator: (value) =>
                                value == null ? 'Select Country' : null,
                            hint: Text("Select Country"),
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _country = value;
                              });
                            },
                            items: countries.map((country) {
                              return DropdownMenuItem(
                                value: country['id'].toString(),
                                child: Text(country['country_name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: DropdownButtonFormField(
                            value: _county,
                            validator: (value) =>
                                value == null ? 'Select County' : null,
                            isExpanded: true,
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
                            items: counties.map((county) {
                              return DropdownMenuItem(
                                value: county['id'].toString(),
                                child: Text(county['county_name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: DropdownButtonFormField(
                            value: _sub_county,
                            validator: (value) =>
                                value == null ? 'Select Sub County' : null,
                            isExpanded: true,
                            hint: Text("Select Sub County"),
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _sub_county = value;
                              });
                            },
                            items: sub_counties.map((subcounty) {
                              return DropdownMenuItem(
                                value: subcounty['id'].toString(),
                                child: Text(subcounty['sub_county_name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            maxLength: 250,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderSide: new BorderSide(color: Colors.teal)),
                              labelText: 'Address',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Address";
                              }
                            },
                            onSaved: (String value) {
                              _address = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                      child: Text("Produce Types"),
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: CheckboxListTile(
                          title: Text(
                            "Crop",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: cropcheckedValue,
                          onChanged: (newValue) {
                            setState(() {
                              cropcheckedValue = newValue;
                            });

                            print(cropcheckedValue);
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        )),
                        Flexible(
                            child: CheckboxListTile(
                          title: Text(
                            "Livestock",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: livestockcheckedValue,
                          onChanged: (newValue) {
                            setState(() {
                              livestockcheckedValue = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        )),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: DropdownButtonFormField(
                            value: _gender,
                            // icon: Icon(Icons.arrow_downward),
                            // iconSize: 20,
                            // elevation: 10,
                            isExpanded: true,
                            hint: Text("Select Gender"),
                            style: TextStyle(color: Colors.green),
                            validator: (value) =>
                                value == null ? 'Select Gender' : null,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                            items: genders.map((gender) {
                              return DropdownMenuItem(
                                value: gender['id'].toString(),
                                child: Text(gender['gender_name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Date Of Birth"),
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("${selectedDate.toLocal()}".split(' ')[0]),
                              SizedBox(
                                height: 20.0,
                              ),
                              RaisedButton(
                                onPressed: () => _selectDate(context),
                                child: Text('Select date'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderSide: new BorderSide(color: Colors.teal)),
                              labelText: 'Total Land Size in Acres',
                              labelStyle: TextStyle(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Total Landisze ";
                              }
                            },
                            onSaved: (String value) {
                              _landsize = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: _isLoading ? null : _registerFarmer,
                        disabledColor: Colors.lightGreen,
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 16.0,
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
                    //   "Enter the Farmers Details",
                    //   style: TextStyle(fontSize: 16.0.0),
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     TextFormField(
                    //       decoration: InputDecoration(
                    //         labelText: 'First Name',
                    //         labelStyle: TextStyle(fontSize: 16.0),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
