import 'package:flutter/material.dart';

import 'main.dart';

abstract class RouteNames {
  const RouteNames._();

  static const initialRoute = home;

  static const home = '/';
  static const counter = '/counter';
}

abstract class RoutesBuilder {
  const RoutesBuilder._();

  // static final routes = <String, Widget Function(BuildContext)>{
  //   RouteNames.home: (_) => const HomePage(
  //         title: DemoApp.title,
  //       ),
  //   RouteNames.counter: (_) => const CounterPage(
  //         title: DemoApp.title,
  //       ),
  // };

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(
            title: DemoApp.title,
          ),
          settings: settings,
        );

      case RouteNames.counter:
        return MaterialPageRoute<int?>(
          builder: (_) => CounterPage(
            title: DemoApp.title,
            lastCounter: settings.arguments as int? ?? 0,
          ),
          settings: settings,
        );
    }

    return null;
  }
}
