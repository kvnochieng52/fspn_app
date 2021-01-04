import 'package:flutter/material.dart';

class FarmerInputShowPage extends StatefulWidget {
  final data;
  const FarmerInputShowPage({Key key, @required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FarmerInputShowState();
  }
}

class _FarmerInputShowState extends State<FarmerInputShowPage> {
  @override
  Widget build(BuildContext context) {
    return (Text("Organizations Index"));
  }
}
