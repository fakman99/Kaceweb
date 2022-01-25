import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _setTitle(String what, PageRoute<dynamic> routeFrom, PageRoute<dynamic> routeTo) {
    final oldScreenName = routeFrom.settings.name;
    final newScreenName = routeTo.settings.name;
    final uri = Uri.parse(newScreenName ?? "");
    final routeName = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : "";
    switch ("/$routeName") {
      case "/"  : return setTitle("Accueil");
      case "/about"    : return setTitle("À propos");
      case "/conditions" : return setTitle("Conditions");
      // etc ...
    }
    setTitle("Not Found");
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) _setTitle("push", previousRoute, route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute && oldRoute is PageRoute) _setTitle("replace", oldRoute, newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) _setTitle("pop", route, previousRoute);
  }
}

void setTitle([String? title]) async {
  Future.microtask(() {
    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: "Kacé | ${title ?? 'Your Tagline'}",
      primaryColor: Colors.blue.value, // your app primary color
    ));
  });
}