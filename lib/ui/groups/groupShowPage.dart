import 'package:flutter/material.dart';

class GroupShowPage extends StatefulWidget {
  final data;

  const GroupShowPage({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupShowState();
  }
}

class _GroupShowState extends State<GroupShowPage> {
  @override
  Widget build(BuildContext context) {
    return (Text("Organizations Index"));
  }
}
