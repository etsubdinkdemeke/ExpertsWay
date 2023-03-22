// ignore_for_file: unused_local_variable, deprecated_member_use, unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/theme.dart';
import 'package:learncoding/theme/config.dart' as config;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _formKey = GlobalKey<FormState>();
String? firstName, lastName, birthdate, gender, email, occupation;
String? fnameError, lnameError, emailError, occupationError;
TextEditingController dateInputController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
  late String namee;
  String? title;
  bool isSaved = false;

  @override
  void initState() {
    getValue();
    dateInputController.text = "19-07-1997";
    super.initState();
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namee = prefs.getString('name')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text =
        Provider.of<ThemeProvider>(context).currentTheme == ThemeMode.dark
            ? 'DarkTheme'
            : 'LightTheme';
    TextTheme textTheme = Theme.of(context).textTheme;
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 40, left: 5, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.grey,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Edit Profile',
                  textAlign: TextAlign.end,
                  style: textTheme.headline6,
                ),
                const SizedBox(
                  width: 35,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  _container(context, false, null, namee, TextInputType.name,
                      BoxIcons.bx_user, 20, firstName, "fname", (() {})),
                  fnameError != null && isSaved
                      ? errorMessage(fnameError.toString())
                      : Container(),
                  _container(context, false, null, lastName, TextInputType.name,
                      BoxIcons.bx_user, 20, lastName, "lname", (() {})),
                  lnameError != null && isSaved
                      ? errorMessage(lnameError.toString())
                      : Container(),
                  _container(
                      context,
                      true,
                      dateInputController,
                      null,
                      TextInputType.none,
                      Icons.cake_outlined,
                      21,
                      birthdate,
                      "birthDate", () async {
                    var dateFormat = DateFormat('d-MM-yyyy');
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050));
                    if (pickedDate != null) {
                      dateInputController.text =
                          dateFormat.format(pickedDate).toString();
                      birthdate = dateFormat.format(pickedDate).toString();
                    }
                  }),
                  _container(
                      context,
                      false,
                      null,
                      email,
                      TextInputType.emailAddress,
                      Icons.mail_outline,
                      21,
                      email,
                      "email",
                      (() {})),
                  emailError != null && isSaved
                      ? errorMessage(emailError.toString())
                      : Container(),
                  _container(
                    context,
                    false,
                    null,
                    occupation,
                    TextInputType.name,
                    BoxIcons.bx_briefcase,
                    21,
                    occupation,
                    "occupation",
                    (() {}),
                  ),
                  occupationError != null && isSaved
                      ? errorMessage(occupationError.toString())
                      : Container(),
                ])),
          ),
          const SizedBox(height: 50),
          buildButton("Save", (() {
            isSaved = false;
            final isValidForm = _formKey.currentState!.validate();
            setState(() {
              isSaved = true;
            });
            if (isValidForm) {
              if (kDebugMode) {
                print("valid");
              }
            }
          }), const Color(0xFF0396FF),
              const Color.fromARGB(255, 110, 195, 255)),
          const SizedBox(height: 30),
          buildButton(
              "Delete Account",
              () {},
              const Color.fromARGB(255, 255, 0, 0),
              const Color.fromARGB(255, 253, 47, 47))
        ]),
      ),
    );
  }

  Widget _container(
      BuildContext context,
      bool readOnly,
      TextEditingController? controller,
      String? initialValue,
      TextInputType? inputType,
      IconData icon,
      double iconSize,
      String? value,
      String? type,
      VoidCallback onTap) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Color secondbackgroundColor = Theme.of(context).backgroundColor;
    IconThemeData icontheme = Theme.of(context).iconTheme;

    String? hintText(String? inputType) {
      if (inputType == "fname") {
        return "First Name";
      } else if (inputType == "lname") {
        return "Last Name";
      } else if (inputType == "email") {
        return "Email Address";
      } else if (inputType == "occupation") {
        return "Occupation";
      } else if (inputType == "birthDate") {
        return "Birthdate";
      }
      return null;
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: themeProvider.currentTheme == ThemeData.dark()
                      ? Colors.transparent
                      : const Color.fromARGB(54, 188, 187, 187),
                )
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    readOnly: readOnly,
                    controller: controller,
                    initialValue: initialValue,
                    keyboardType: inputType,
                    style: textTheme.bodyText2,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            themeProvider.currentTheme == ThemeData.light()
                                ? Colors.white
                                : secondbackgroundColor,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        hintText: hintText(type),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorStyle: const TextStyle(fontSize: 0.01),
                        contentPadding: const EdgeInsets.only(
                            left: 25, top: 10, bottom: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          icon,
                          size: iconSize,
                          color: const Color.fromARGB(255, 172, 172, 171),
                        )),
                    onTap: onTap,
                    onChanged: (value) {
                      if (Type == "fname") {
                        firstName = value;
                      } else if (Type == "lname") {
                        lastName = value;
                      } else if (Type == "birthdate") {
                        birthdate = value;
                      } else if (Type == "email") {
                        email = value;
                      } else if (Type == "occupation") {
                        occupation = value;
                      }
                    },
                    validator: ((value) {
                      if (type == "fname") {
                        if (value != null && value.length < 3) {
                          fnameError =
                              "Please enter your first name (Minimum of 3 characters)";
                          return fnameError;
                        } else {
                          fnameError = null;
                          return null;
                        }
                      } else if (type == "lname") {
                        if (value!.isNotEmpty) {
                          if (value.length < 3) {
                            lnameError =
                                "Please enter your last name (Minimum of 3 characters)";
                            return lnameError;
                          } else {
                            lnameError = null;
                          }
                        }
                        return null;
                      } else if (type == "email") {
                        final emailRegex = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if (value!.isEmpty) {
                          emailError =
                              "Please enter a valid email address (ex. abc@gmail.com)";
                          return emailError;
                        } else if (emailRegex.hasMatch(value) == false) {
                          emailError =
                              "Please enter a valid email address (ex. abc@gmail.com)";
                          return emailError;
                        }
                        emailError = null;
                        return null;
                      } else if (type == "occupation") {
                        final ocupationRegex = RegExp(r'^([^0-9]*)$');
                        if (ocupationRegex.hasMatch(value!) == false) {
                          occupationError =
                              "Please enter a valid occupation (ex. Student, Engineer)";
                          return occupationError;
                        } else {
                          occupationError = null;
                          return null;
                        }
                      }
                      return null;
                    })))),
      ],
    );
  }
}

Widget buildButton(
    String label, VoidCallback onTap, Color color1, Color color2) {
  return SizedBox(
    key: UniqueKey(),
    width: 290,
    height: 50,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color1, color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}

Widget errorMessage(String? error) {
  return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 5, left: 2),
      child: Text(
        error.toString(),
        style: const TextStyle(color: Colors.red),
      ));
}
