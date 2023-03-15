import 'package:learncoding/routes/page.dart';
import 'package:learncoding/ui/pages/navmenu/menu_dashboard_layout.dart';
import 'package:learncoding/ui/pages/onboarding1.dart';
import 'package:learncoding/ui/pages/undefined_screen.dart';
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
              const RestartWidget(
                child: MyApp(),
              ),
            ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
    const MenuDashboardLayout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(fontFamily: 'Poppins'),
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => CupertinoPageRoute(
          builder: (context) => UndefinedScreen(
                name: settings.name,
              )),
      // theme: Provider.of<ThemeModel>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      getPages: pages,
      home: const SplashScreen(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({this.child, super.key});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<RestartWidgetState>()!.restartApp();
  }

  @override
  RestartWidgetState createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
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
      animationDuration: const Duration(milliseconds: 1500),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      pageTransitionType: PageTransitionType.fade,
      nextScreen:
          name == null ? const Onboarding() : const MenuDashboardLayout(),
    );
  }
}
