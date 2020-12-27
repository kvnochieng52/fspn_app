import 'package:flutter/material.dart';
import 'package:fspn/ui/farm_inputs/farmInputsIndexPage.dart';
import 'package:fspn/ui/farmers/farmersIndexPage.dart';
import 'package:fspn/ui/groups/groupsIndexPage.dart';
import 'package:fspn/ui/login.dart';
import 'package:fspn/ui/dashboard/dashboardPage.dart';
import 'package:fspn/ui/organizations/organizationsIndexPage.dart';
import 'package:fspn/ui/profile/ProfilePage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
        break;

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardPage());
        break;

      case '/farmers':
        return MaterialPageRoute(builder: (_) => FarmersIndexPage());
        break;
      case '/groups':
        return MaterialPageRoute(builder: (_) => GroupsIndexPage());
        break;
      case '/organizations':
        return MaterialPageRoute(builder: (_) => OrganizationsIndexPage());
        break;

      case '/farm_inputs':
        return MaterialPageRoute(builder: (_) => FarmInputsIndexPage());
        break;
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
