import 'package:flutter/material.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GroupCreateState();
  }
}

class _GroupCreateState extends State<GroupCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'New Group'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/create_group'),
      ),
    );
  }
}
