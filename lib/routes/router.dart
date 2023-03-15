import 'package:flutter/foundation.dart';
import 'package:learncoding/routes/routing_constants.dart';
import 'package:learncoding/ui/pages/home.dart';
import 'package:learncoding/ui/pages/undefined_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncoding/analytics/analytics_service.dart';

List<String> navStack = ["Home"];
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoute.homeRoute:
      navStack.add("Splash");
      if (kDebugMode) {
        print(navStack);
      }
      analytics.setCurrentScreen(screenName: AppRoute.homeRoute);
      return CupertinoPageRoute(builder: (context) => const Home());
    // case SearchRoute:
    //   navStack.add("Search");
    //   print(navStack);
    //   analytics.setCurrentScreen(screenName: SearchRoute);
    //   return PageRouteBuilder(
    //       pageBuilder: (context, animation1, animation2) => SearchScreen());
    default:
      navStack.add("undefined");
      if (kDebugMode) {
        print(navStack);
      }
      analytics.setCurrentScreen(screenName: "/undefined");
      return CupertinoPageRoute(
        builder: (context) => UndefinedScreen(
          name: settings.name,
        ),
      );
  }
}
