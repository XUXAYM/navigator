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

  static final routes = <String, Widget Function(BuildContext)>{
    //TODO
  };

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    //TODO
  }
}
