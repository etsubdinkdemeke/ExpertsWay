import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/shared_preference/shared_preference.dart';
import '../main.dart';
import '../routes/routing_constants.dart';
import '../services/api_controller.dart';
import '../ui/widgets/gradient_button.dart';
import '../utils/color.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedLogIn;
  const LoginPage({Key? key, required this.onClickedLogIn}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPressed = true;
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderSide: Divider.createBorderSide(context), borderRadius: BorderRadius.circular(10));

    return CupertinoPageScaffold(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Image.asset('assets/images/splash.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Hey there,",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: TextFormField(
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
                              validator: (value) => value != null && !value.contains('@') || !value!.contains('.') ? 'Enter a valid Email' : null),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPressed = !isPressed;
                                  });
                                },
                                icon: isPressed ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
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
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Entre a password';
                              } else if (value!.length < 8) {
                                return 'password length can\'t be lessthan 8';
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () => Get.toNamed(AppRoute.forgotpasswordPage),
                            child: const Text(
                              "Forgot your password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 165, 165, 165)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GradientBtn(
                  onPressed: login,
                  btnName: 'Login',
                  defaultBtn: true,
                  isPcked: false,
                  width: 280,
                  height: 52,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Or",
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                        ),
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
                                border: Border.all(width: 2, color: const Color.fromARGB(208, 178, 178, 178))),
                            child: Image.asset("assets/images/google.png")),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(text: "Don't have an account?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = widget.onClickedLogIn,
                        text: " Register",
                        style: const TextStyle(color: maincolor, fontSize: 17, fontWeight: FontWeight.w700))
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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final user = await googleSignIn.signIn();
      String? name = "";
      String? image = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
      if (user!.displayName != null) {
        name = user!.displayName;
      }
      if (user.photoUrl != null) {
        image = user.photoUrl;
      }

      String res = await ApiProvider().registerUser(user!.email, name!, name!, user!.id, "google");

      if (res == "success") {
        Get.toNamed(AppRoute.programmingOptions);
      } else {
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          backgroundColor: maincolor,
          borderRadius: BorderRadius.circular(8),
          message: res,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
      // UserPreferences.setuser(image!, name!);
      // Get.toNamed(AppRoute.programmingOptions);
    } catch (error) {
      print("Error during login: ");
      print(error);
      await googleSignIn.disconnect();
      // UserPreferences.setuser("https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50", "testDisplayName");
      // Get.toNamed(AppRoute.programmingOptions);
    }
  }

  Future login() async {
    final form = formkey.currentState!;
    if (form.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(color: maincolor),
              ));

      String res = await ApiProvider().loginUser(emailController.text, passwordController.text, 'email_password');
      navigatorKey.currentState!.popUntil((rout) => rout.isFirst);

      if (res == "success") {
        Get.toNamed(AppRoute.programmingOptions);
      } else {
        Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          titleSize: 20,
          messageSize: 17,
          backgroundColor: maincolor,
          borderRadius: BorderRadius.circular(8),
          message: res,
          duration: const Duration(seconds: 5),
        ).show(context);
      }
    }
  }
}
