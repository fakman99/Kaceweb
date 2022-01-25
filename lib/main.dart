import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kace/const.dart';
import 'package:kace/pages/Homepage.dart';
import 'package:kace/pages/about.dart';
import 'package:kace/pages/conditions.dart';
import 'package:kace/extensions/routes.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'extensions/RouteObserver.dart';
import 'pages/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 3840,
          minWidth: 360,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(360, name: MOBILE, scaleFactor: 0.6),
            ResponsiveBreakpoint.resize(390, name: MOBILE, scaleFactor: 0.6),
            ResponsiveBreakpoint.resize(403, name: MOBILE, scaleFactor: 0.6),
            ResponsiveBreakpoint.resize(412, name: MOBILE, scaleFactor: 0.6),
            ResponsiveBreakpoint.resize(414, name: MOBILE, scaleFactor: 0.6),
            ResponsiveBreakpoint.autoScale(768, name: TABLET, scaleFactor: 0.8),
            ResponsiveBreakpoint.autoScale(1280, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1920, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2560, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(3840, name: "4k", scaleFactor: 0.8),
          ],
          background: Container(color: Colors.white)),
      navigatorObservers: [MyRouteObserver()],
      initialRoute: Homepage.route,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case Routes.home:
              return Homepage();
            case Routes.about:
              return About();
            case Routes.cond:
              return Conditions();
            default:
              return SizedBox.shrink();
          }
        });
      },
    );
  }
}
