import 'package:flutter/material.dart';
import 'package:to_do_app/view/entry_view.dart';
import 'package:to_do_app/view/error_page.dart';
import 'package:to_do_app/view/home_view.dart';
import 'package:to_do_app/view/job_insert_view.dart';

class RouteGenerator {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _creatRoute(const EntryView());
      case '/home':
        return _creatRoute(const HomeView());
      case '/jobInsertView':
        return _creatRoute(const JobInsertView());
      default:
        return _creatRoute(const ErrorPage());
    }
  }

  static _creatRoute(Widget pageWidget) {
    return MaterialPageRoute(
      builder: (context) => pageWidget,
    );
  }
}
