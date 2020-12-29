import 'package:flutter/material.dart';

class FarmerShowPage extends StatefulWidget {
  final data;

  const FarmerShowPage({Key key, @required this.data}) : super(key: key);
  //const FarmerShowPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return _FarmerShowState();
  }
}

class _FarmerShowState extends State<FarmerShowPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("farmer show"),
        Text(widget.data['farmer_id']),
      ],
    );
  }
}
