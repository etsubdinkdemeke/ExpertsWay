import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/shared_preference/shared_preference.dart';
import '../main.dart';
import '../routes/routing_constants.dart';
import '../services/api_controller.dart';
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
  final formkey = GlobalKey<FormState>();
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
                              controller: firstnameController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.account_circle_outlined),
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
                              validator: (value) => value != null && value.isEmpty ? 'Enter a first name' : null),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: TextFormField(
                              controller: lastnameController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.account_circle_outlined),
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
                              validator: (value) => value != null && value.isEmpty ? 'Enter a last name' : null),
                        ),
                        const SizedBox(
                          height: 20,
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
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                activeColor: maincolor,
                                value: checkPolicy,
                                onChanged: (onChanged) {
                                  setState(() {
                                    checkPolicy = !checkPolicy;
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                "By continuing you accept our Privacy Policy and Terms of Use",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Color.fromARGB(255, 165, 165, 165)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GradientBtn(
                  onPressed: register,
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
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 17),
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
                                border: Border.all(width: 2, color: const Color.fromARGB(208, 178, 178, 178))),
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
                    const TextSpan(text: "Already have an account?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = widget.onClickedRegister,
                        text: " Login",
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
      String? image = "";
      if (user!.displayName != null) {
        name = user!.displayName;
      }
      if (user.photoUrl != null) {
        image = user.photoUrl;
      }

      String res = await ApiProvider().registerUser(
          user!.email,
          name!,
          name!,
          user!.id,
          "google");

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

  Future register() async {
    final form = formkey.currentState!;
    if (form.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(color: maincolor),
              ));

      String res = await ApiProvider().registerUser(emailController.text, firstnameController.text, lastnameController.text, passwordController.text,'email_password');
      navigatorKey.currentState!.popUntil((rout) => rout.isFirst);

      if (res == "success") {
        Get.toNamed('/verification', arguments: {'email': emailController.value.text, 'isResetPass': false});
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

