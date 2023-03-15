import 'package:learncoding/api/google_signin_api.dart';
import 'package:learncoding/ui/pages/help.dart';
import 'package:learncoding/ui/pages/navmenu/dashboard.dart';
import 'package:learncoding/ui/pages/navmenu/menu_dashboard_layout.dart';
import 'package:learncoding/ui/pages/onboarding1.dart';
import 'package:learncoding/ui/pages/profile.dart';
import 'package:learncoding/ui/pages/setting.dart';
import 'package:learncoding/ui/pages/undefinedScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learncoding/global/globals.dart' as globals;
import 'package:learncoding/routes/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

String? name;
String? image;
late SharedPreferences prefs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  SharedPreferences.getInstance().then((prefs) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(
              RestartWidget(
                child: MyApp(),
              ),
            ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getLoginStatus() async {
    WidgetsFlutterBinding.ensureInitialized();

    globals.gAuth.googleSignIn.isSignedIn().then((value) {
      prefs.setBool("isLoggedin", value);
    });
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    name = prefs.getString('name');
    image = prefs.getString('image');
  }

  @override
  void initState() {
    getLoginStatus();
    MenuDashboardLayout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (settings) => CupertinoPageRoute(
            builder: (context) => UndefinedScreen(
                  name: settings.name,
                )),
        // theme: Provider.of<ThemeModel>(context).currentTheme,
        debugShowCheckedModeBanner: false,
        // home: Settings(),
        // home: Profile(),
        // home: name == null ? Onboarding() : MenuDashboardLayout(),
        home: SplashScreen());
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset('assets/images/splash.png'),
        duration: 3000,
        splashIconSize: 350,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: Duration(milliseconds: 1500),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        pageTransitionType: PageTransitionType.fade,
        nextScreen: name == null ? Onboarding() : MenuDashboardLayout());
  }
}
