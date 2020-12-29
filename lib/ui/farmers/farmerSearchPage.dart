import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fspn/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FarmerSearchState();
  }
}

class _FarmerSearchState extends State<FarmerSearchPage> {
  bool _searchFlag = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: _searchFlag ? _buildFarmersList() : buildNoContent(),
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

  var farmers = List();

  _getFarmers() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = json.decode(localStorage.getString('user'));

    var res =
        await CallApi().getData('farmer/get_farmers/' + user['id'].toString());

    setState(() {
      farmers = json.decode(res.body);
    });
  }

  Widget _buildFarmersList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: farmers.length,
      padding: const EdgeInsets.all(8.5),
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: Column(
            children: <Widget>[
              Divider(height: 5.5),
              ListTile(
                title: Text(
                  "${farmers[position]['first_name']} ${farmers[position]['last_name']}",
                  style: TextStyle(fontSize: 15.0),
                ),
                subtitle: Text(
                    "${farmers[position]['county_name']}, ${farmers[position]['sub_county_name']}",
                    style: TextStyle(
                        fontSize: 13.9,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic)),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "${farmers[position]['first_name'][0]}".toUpperCase(),
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
                      "${farmers[position]['id']}",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.more_horiz), // icon-1
                    //Icon(Icons.chevron_right), // icon-2
                  ],
                ),
                onTap: () => Navigator.of(context).pushNamed('/show_farmer',
                    arguments: {"farmer_id": "${farmers[position]['id']}"}),
              )
            ],
          ),
        );
      },
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
              "Find Farmers",
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
          hintText: "Search for Farmer...",
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.account_circle,
            size: 24.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
        onChanged: (text) => handleSearch(text),
      ),
    );
  }
}
