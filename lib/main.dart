import 'package:learncoding/db/course_database.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/routes/page.dart';
import 'package:learncoding/theme/theme.dart';
import 'package:learncoding/ui/pages/navmenu/menu_dashboard_layout.dart';
import 'package:learncoding/ui/pages/onboarding1.dart';
import 'package:learncoding/ui/pages/setting.dart';
import 'package:learncoding/ui/pages/undefined_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learncoding/global/globals.dart' as globals;
import 'package:learncoding/routes/router.dart' as router;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

String? name;
String? image;
late SharedPreferences prefs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferennces = await SharedPreferences.getInstance();
  final isDark = sharedPreferennces.getBool('is_dark') ?? false;
  // await Firebase.initializeApp();

  SharedPreferences.getInstance().then((prefs) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(
              RestartWidget(
                child: MyApp(isDark: isDark),
              ),
            ));
  });
}

class MyApp extends StatefulWidget {
  final bool isDark;
  const MyApp({
    super.key,
    required this.isDark,
  });

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
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(widget.isDark),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final settings = context.read<ThemeProvider>();
        return GetMaterialApp(
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          themeMode: themeProvider.currentTheme == ThemeData.light()
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
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
      });
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
    // final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Image.asset('assets/images/splash.png'),
        duration: 3000,
        splashIconSize: 350,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(milliseconds: 1500),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        pageTransitionType: PageTransitionType.fade,
        nextScreen:
            name == null ? const Onboarding() : const MenuDashboardLayout(),
      ),
    );
  }
}
