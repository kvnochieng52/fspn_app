import 'package:flutter/material.dart';
import 'package:fspn/ui/farm_inputs/farmInputsIndexPage.dart';
import 'package:fspn/ui/farmers/farmerAddProducePage.dart';
import 'package:fspn/ui/farmers/farmerShowPage.dart';
import 'package:fspn/ui/farmers/farmersIndexPage.dart';
import 'package:fspn/ui/farmers/farmersSearchPage.dart';
import 'package:fspn/ui/farmers/newFarmerPage.dart';
import 'package:fspn/ui/farmers/farmerEditPage.dart';
import 'package:fspn/ui/groups/groupsIndexPage.dart';
import 'package:fspn/ui/groups/groupCreatePage.dart';
import 'package:fspn/ui/groups/groupShowPage.dart';
import 'package:fspn/ui/groups/groupEditPage.dart';
import 'package:fspn/ui/groups/groupSearchPage.dart';
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

      case '/new_farmer':
        return MaterialPageRoute(builder: (_) => NewFarmerPage());
        break;
      case '/search_farmer':
        return MaterialPageRoute(builder: (_) => FarmerSearchPage());
        break;

      case '/edit_farmer':
        return MaterialPageRoute(
          builder: (_) => FarmerEditPage(
            data: args,
          ),
        );
        break;

      case '/show_farmer':
        return MaterialPageRoute(
          builder: (_) => FarmerShowPage(
            data: args,
          ),
        );
        break;

      case '/add_farmer_produce':
        return MaterialPageRoute(
          builder: (_) => FarmersAddProducePage(
            data: args,
          ),
        );
        break;

      case '/groups':
        return MaterialPageRoute(builder: (_) => GroupsIndexPage());
        break;
      case '/new_group':
        return MaterialPageRoute(builder: (_) => GroupCreatePage());
        break;
      case '/search_group':
        return MaterialPageRoute(builder: (_) => GroupSearchPage());
        break;
      case '/edit_group':
        return MaterialPageRoute(
          builder: (_) => GroupEditPage(
            data: args,
          ),
        );
        break;

      case '/show_group':
        return MaterialPageRoute(
          builder: (_) => GroupShowPage(
            data: args,
          ),
        );
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
