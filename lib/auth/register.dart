import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../api/google_signin_api.dart';
import '../api/shared_preference/shared_preference.dart';
import '../ui/pages/navmenu/menu_dashboard_layout.dart';
import '../ui/widgets/gradient_button.dart';
import '../utils/color.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onClickedRegister;

  const RegisterPage({super.key, required this.onClickedRegister});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPressed = true;
  bool checkPolicy = false;
  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));

    return CupertinoPageScaffold(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Let's get you set up,",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Create an acoount",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        shadowColor: Colors.black,
                        child: TextField(
                          controller: firstnameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: "first name",
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        shadowColor: Colors.black,
                        child: TextField(
                          controller: lastnameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: "last name",
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        shadowColor: Colors.black,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline),
                            hintText: "email",
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        shadowColor: Colors.black,
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                              },
                              icon: isPressed
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            hintText: "password",
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: isPressed,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              activeColor: maincolor,
                              value: checkPolicy,
                              onChanged: (onChanged) {
                                setState(() {
                                  checkPolicy = !checkPolicy;
                                });
                              }),
                          Container(
                            // padding: EdgeInsets.only(
                            //   left: 30,
                            // ),
                            width: MediaQuery.of(context).size.width - 150,
                            height: 50,
                            child: Text(
                              "By continuing you accept our Privacy Policy and Terms of Use",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 165, 165, 165)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GradientBtn(
                  onPressed: () {},
                  btnName: 'Register',
                  defaultBtn: true,
                  isPcked: false,
                  width: 280,
                  height: 52,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                        flex: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: signin,
                        child: Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2,
                                    color: Color.fromARGB(208, 178, 178, 178))),
                            child: Image.asset("assets/images/google.png")),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedRegister,
                        text: " Login",
                        style: TextStyle(
                            color: maincolor,
                            fontSize: 17,
                            fontWeight: FontWeight.w700))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      UserPreferences.setuser(
          "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
          "testDisplayName");
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => (const MenuDashboardLayout())));
  }
}
