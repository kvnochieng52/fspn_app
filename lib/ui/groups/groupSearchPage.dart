import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GroupSearchState();
  }
}

class _GroupSearchState extends State<GroupSearchPage> {
  bool _searchFlag = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: _searchFlag ? _buildGroupList() : buildNoContent(),
    );
  }

  _clearSearch() {
    setState(() {
      searchController.clear();
      _searchFlag = false;
    });
  }

  handleSearch(text) {
    _getFarmers();
    setState(() {
      _searchFlag = true;
    });

    //print(searchResults.length);
  }

  var groups = List();

  _getFarmers() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res = await CallApi().getData(
        "group/search_groups/${user['id'].toString()}/${searchController.text}");

    setState(() {
      groups = json.decode(res.body);
    });
  }

  Widget _buildGroupList() {
    return ListView(
      children: <Widget>[
        _buildTopStrip(),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: groups.length,
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
                        "${groups[position]['group_name']}",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${groups[position]['sub_county_name']}, ${groups[position]['county_name']}",
                            style: TextStyle(
                                fontSize: 13.9,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Description: ",
                                style: TextStyle(
                                    fontSize: 13.9,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${groups[position]['description']}",
                                style: TextStyle(
                                  fontSize: 13.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        "${groups[position]['group_name'][0]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Column(
                      //spacing: 12, // space between two icons
                      children: <Widget>[
                        Text(
                          "GFSPN-${groups[position]['id']}",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 13.0,
                            child: Text(
                              "${groups[position]['members_count']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ), // icon-1
                        //Icon(Icons.chevron_right), // icon-2
                      ],
                    ),
                    // onTap: () => Navigator.of(context).pushNamed(
                    //   '/show_group',
                    //   arguments: {"group_id": "${groups[position]['id']}"},
                    // ),

                    onTap: () => Navigator.of(context).pushNamed(
                      '/show_group',
                      arguments: {"group_id": "${groups[position]['id']}"},
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
                    "Groups Found..",
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
                groups.length.toString(),
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

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(
              'images/logo_colored.png',
              height: orientation == Orientation.portrait ? 250 : 100.0,
              width: orientation == Orientation.portrait ? 250 : 100.0,
            ),
            Text(
              "Find Groups",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                //fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: orientation == Orientation.portrait ? 20.0 : 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: TextFormField(
        autofocus: true,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for Groups...",
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.supervised_user_circle,
            size: 24.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
        onChanged: (text) {
          if (text.length >= 3) {
            handleSearch(text);
          }
        },
      ),
    );
  }
}
