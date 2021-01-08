import 'package:flutter/material.dart';

class OrganizationShowPage extends StatefulWidget {
  final data;
  const OrganizationShowPage({Key key, @required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OrganizationShowState();
  }
}

class _OrganizationShowState extends State<OrganizationShowPage> {
  @override
  Widget build(BuildContext context) {
    return (Text("SHow Organization"));
  }
}
