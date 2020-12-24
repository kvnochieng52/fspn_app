import 'package:flutter/material.dart';
import 'package:fspn/ui/login.dart';
// import 'package:my_zuku/ui/register.dart';
// import 'package:my_zuku/ui/Dashboard.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
        break;

      case '/register':
        //return MaterialPageRoute(builder: (_) => Register());
        break;

      case '/dashboard':
        //return MaterialPageRoute(builder: (_) => Dashboard());
        break;
      // case '/second':
      //   if (args is String) {
      //     return MaterialPageRoute(
      //         builder: (_) => SecondPage(
      //               data: args,
      //             ));
      //   }
      //   return _errorRoute();

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
