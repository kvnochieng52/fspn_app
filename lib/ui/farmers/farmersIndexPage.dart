import 'package:flutter/material.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';

class FarmersIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FarmersIndexState();
  }
}

class _FarmersIndexState extends State<FarmersIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Farmers'),
      drawer: drawer(context),
      backgroundColor: Color(0xFFF0F0F0),
      body: Text("Farmers"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => print('hello'),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.add),
      //   label: Text("New Farmer"),
      //   onPressed: () => print('hello'),
      // ),
    );
  }
}
