import 'package:learncoding/api/shared_preference/shared_preference.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:learncoding/ui/pages/navmenu/menu_dashboard_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/api/google_signin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController(initialPage: 0);

  int? pageNumber;
  List widgets = [];
  @override
  void initState() {
    pageNumber = 0;
    super.initState();
    // signin();
  }

  void createWidgets() {
    widgets.addAll([
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/1.png'),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "Easy access to video lectures, & reading materials.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 14,
                  color: Color(0xFFFFFFFF)),
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/2.png'),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "Ask questions, earn coins and dominate the global leaderboard.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 14,
                  color: Color(0xFFFFFFFF)),
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/logo.png'),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "E-Learn",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 28,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              "The complete E-learning solution for students of all ages!\n\n\nJoin for FREE now!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 14,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CupertinoButton(
              color: Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Sign in with Google ➡",
                    style: TextStyle(
                        fontFamily: 'Red Hat Display',
                        fontSize: 16,
                        color: Color(0xFF0083BE),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: signin)
        ],
      ),
    ]);
  }

  Future signin() async {
  
  try {
      final user = await GoogleSignInApi.login();
      String? name = user!.displayName;
      String? image = user.photoUrl;

      // SharedPreferences pref = await SharedPreferences.getInstance();
      UserPreferences.setuser(image!, name!);

   } catch (error) {
   // console.error("Error during login: ", error);
      UserPreferences.setuser("https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50", "testDisplayName");
  }

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => (MenuDashboardLayout())));
  }

  @override
  Widget build(BuildContext context) {
    createWidgets();
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFABDCFF),
                Color(0xFF0396FF),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Positioned(
              top: 0, left: 0, child: Image.asset('assets/images/wave.png')),
          Align(
            alignment: Alignment.center,
            child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    pageNumber = value;
                  });
                },
                itemCount: 3,
                itemBuilder: (context, index) => widgets[index]),
          ),
          pageNumber == 2
              ? Container()
              : Positioned(
                  bottom: 10,
                  right: 10,
                  child: CupertinoButton(
                    child: Icon(
                      pageNumber == 1
                          ? BoxIcons.bx_check
                          : BoxIcons.bx_chevron_right,
                      color: Color(0xFFFFFFFF),
                      size: 30,
                    ),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn);
                    },
                  ))
        ],
      ),
    );
  }
}
