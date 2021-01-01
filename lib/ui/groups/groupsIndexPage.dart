import 'package:flutter/material.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';

class GroupsIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GroupsIndexState();
  }
}

class _GroupsIndexState extends State<GroupsIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Groups'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/new_group'),
      ),
    );
  }
}
