import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:fspn/widgets/drawer.dart';
import 'package:fspn/widgets/header.dart';
import 'package:fspn/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrganizationsIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrganizationsIndexState();
  }
}

class _OrganizationsIndexState extends State<OrganizationsIndexPage> {
  bool organizationsFetched = false;
  List organizations = List();

  @override
  void initState() {
    super.initState();
    _getOrganizations();
  }

  _getOrganizations() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi().getData(
        'organization/get_organizations?user_id=' + user['id'].toString());

    setState(() {
      organizations = json.decode(res.body);
      organizationsFetched = true;
    });
  }

  Widget _buildOrganizationList() {
    return _buildGroupList();
  }

  Widget _buildGroupList() {
    return ListView(
      children: <Widget>[
        _buildTopStrip(),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: organizations.length,
          padding: const EdgeInsets.all(8.5),
          itemBuilder: (BuildContext context, int position) {
            return Card(
              child: Column(
                children: <Widget>[
                  Divider(height: 5.5),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                      child: Text(
                        "${organizations[position]['organization_name']}",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${organizations[position]['sub_county_name']}, ${organizations[position]['county_name']}",
                            style: TextStyle(
                                fontSize: 13.9,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 8.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Contact Person: ",
                                  style: TextStyle(
                                    fontSize: 13.9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Name: ${organizations[position]['contact_person_name']}",
                                  style: TextStyle(
                                    fontSize: 13.9,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Telephone: ${organizations[position]['contact_person_telephone']}",
                                  style: TextStyle(
                                    fontSize: 13.9,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        "${organizations[position]['organization_name'][0]}"
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 17.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Column(
                      children: <Widget>[Icon(Icons.more_vert)],
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                      '/show_organization',
                      arguments: {
                        "organization_id": "${organizations[position]['id']}"
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopStrip() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Registered Organizations",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 13.0,
              child: Text(
                organizations.length.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Organizations'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/new_organization'),
      ),
      body: Container(
        child: organizationsFetched
            ? _buildOrganizationList()
            : circularProgress(),
      ),
    );
  }
}
