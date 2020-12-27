import 'package:flutter/material.dart';

class NewFarmerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewFarmerState();
  }
}

class _NewFarmerState extends State<NewFarmerPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
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
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: mediaQuery.size.width,
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Enter the Farmers Details to Register"),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   "Enter the Farmers Details",
                  //   style: TextStyle(fontSize: 16.0),
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     TextFormField(
                  //       decoration: InputDecoration(
                  //         labelText: 'First Name',
                  //         labelStyle: TextStyle(fontSize: 15),
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
    );
  }
}
