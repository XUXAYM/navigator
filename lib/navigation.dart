import 'package:flutter/material.dart';

import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => key.currentState!;

  Future<dynamic> openCounter(String title, {required int lastCounter}) async {
    return await _navigator.pushNamed(
      RouteNames.counter,
      arguments: lastCounter,
    );
  }

  void pop([dynamic result]) {
    _navigator.pop(result);
  }
}
