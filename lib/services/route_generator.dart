import 'package:bisan_systems_erp/screens/Login_page.dart';
import 'package:bisan_systems_erp/screens/error_page.dart';
import 'package:bisan_systems_erp/widgets/bsn_appbar.dart';
import 'package:bisan_systems_erp/widgets/bsn_drawer.dart';
import 'package:bisan_systems_erp/widgets/bsn_status_bar.dart';
import 'package:bisan_systems_erp/widgets/bsn_tab.dart';
import 'package:bisan_systems_erp/widgets/main_menu.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static String? currentRoute;
  static String? oldRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    currentRoute = settings.name;
    switch (settings.name) {
      case '':
        return _prepareRoute(const LoginPage());
      case 'home':
        return _prepareRoute(const BsnTabWidget());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }

  static bool checkIfSameRoute(context, String newRouteName) {
    bool isNewRouteSameAsCurrent = false;

    if (RouteGenerator.currentRoute == newRouteName) {
      isNewRouteSameAsCurrent = true;
    }

    return isNewRouteSameAsCurrent;
  }

  static Route _prepareRoute(type) {
    assert(type != null);

    if (type is LoginPage) {
      return MaterialPageRoute(builder: (_) => type);
    }

    return MaterialPageRoute(builder: (_) {
      final bool displayMobileLayout = MediaQuery.of(_).size.width < 600;
      return Scaffold(
          appBar: const BsnAppBar(),
          drawer: displayMobileLayout ? const BsnDrawer() : null,
          body: displayMobileLayout
              ? type
              : Row(
                  children: const <Widget>[
                    Expanded(
                      flex: 1,
                      child: MainMenu(),
                    ),
                    VerticalDivider(width: 1),
                    Expanded(
                      flex: 4,
                      child: BsnTabWidget(),
                    ),
                  ],
                ),
          bottomNavigationBar: BsnStatusBar());
    });
  }
}
