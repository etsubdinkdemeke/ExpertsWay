import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Let's get you set up,",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Create an acoount",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
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
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            hintText: "First name",
                            hintStyle: const TextStyle(fontSize: 14),
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(
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
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            hintText: "Last name",
                            hintStyle: const TextStyle(fontSize: 14),
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(
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
                            prefixIcon: const Icon(Icons.mail_outline),
                            hintText: "Email",
                            hintStyle: const TextStyle(fontSize: 14),
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(
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
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 14),
                            filled: true,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: isPressed,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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

                          const Expanded(

                            // width: MediaQuery.of(context).size.width / 1.6,
                            // height: 70,
                            child: Text(
                              "By continuing you accept our Privacy Policy and Terms of Use",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
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
                const SizedBox(
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
                const SizedBox(
                  height: 20,
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Or",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      const SizedBox(
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        208, 178, 178, 178))),
                            child: Image.asset("assets/images/google.png")),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedRegister,
                        text: " Login",
                        style: const TextStyle(
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
