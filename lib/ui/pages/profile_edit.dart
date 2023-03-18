import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:learncoding/main.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final _formKey = GlobalKey<FormState>();
String? firstName, lastName, birthdate, gender, email, occupation;
String? fnameError, lnameError, emailError, occupationError;
FocusNode _focus = FocusNode();
FocusNode _focusDate = FocusNode();
FocusNode _focusGender = FocusNode();
TextEditingController _controller = TextEditingController();
TextEditingController dateInputController = TextEditingController();
var genderValue = ["Male", "Female"];

class _EditProfileState extends State<EditProfile> {
  late String namee;
  String? title;
  bool isSaved = false;

  @override
  void initState() {
    getValue();
    super.initState();
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    namee = prefs.getString('name')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                const Text(
                  'Edit Profile',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Red Hat Display",
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 35,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(children: [
                    _container(
                        context,
                        false,
                        false,
                        null,
                        namee,
                        TextInputType.name,
                        Icons.person,
                        25,
                        firstName,
                        "fname",
                        (() {})),
                    fnameError != null && isSaved
                        ? errorMessage(fnameError.toString())
                        : Container(),
                    _container(
                        context,
                        false,
                        false,
                        null,
                        lastName,
                        TextInputType.name,
                        Icons.person,
                        25,
                        lastName,
                        "lname",
                        (() {})),
                    lnameError != null && isSaved
                        ? errorMessage(lnameError.toString())
                        : Container(),
                    _container(
                        context,
                        true,
                        false,
                        null,
                        DateTime.now().toString(),
                        TextInputType.name,
                        Icons.arrow_drop_down,
                        30,
                        gender,
                        null,
                        (() {})),
                    _container(
                        context,
                        false,
                        false,
                        dateInputController,
                        null,
                        TextInputType.none,
                        Icons.calendar_month,
                        22,
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
                        false,
                        null,
                        email,
                        TextInputType.emailAddress,
                        Icons.mail,
                        22,
                        email,
                        "email",
                        (() {})),
                    emailError != null && isSaved
                        ? errorMessage(emailError.toString())
                        : Container(),
                    _container(
                      context,
                      false,
                      false,
                      null,
                      occupation,
                      TextInputType.name,
                      Icons.badge,
                      22,
                      occupation,
                      "occupation",
                      (() {}),
                    ),
                    occupationError != null && isSaved
                        ? errorMessage(occupationError.toString())
                        : Container(),
                  ])),
            ),
          ),
          const SizedBox(height: 20),
          buildButton("Save", (() {
            isSaved = false;
            final isValidForm = _formKey.currentState!.validate();
            setState(() {
              isSaved = true;
            });
            if (isValidForm) {
              print("valid");
            }
          }), Color(0xFF0396FF), Color.fromARGB(255, 110, 195, 255)),
          const SizedBox(height: 20),
          buildButton("Delete Account", () {}, Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 253, 47, 47))
        ]),
      ),
    );
  }

  Widget _container(
      BuildContext context,
      bool isDropdown,
      bool readOnly,
      TextEditingController? controller,
      String? initialValue,
      TextInputType? inputType,
      IconData icon,
      double iconSize,
      String? Value,
      String? type,
      VoidCallback onTap) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: Color.fromARGB(54, 188, 187, 187))
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: !isDropdown
              ? formItem(context, readOnly, controller, initialValue, inputType,
                  icon, iconSize, Value, type, onTap)
              : DropdownButtonFormField(
                  isExpanded: false,
                  alignment: Alignment.center,
                  icon: Icon(
                    icon,
                    size: iconSize,
                  ),
                  value: "Female",
                  iconSize: 30,
                  items:
                      genderValue.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onTap: () {
                    FocusScope.of(context).requestFocus(_focusGender);
                  },
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorStyle: TextStyle(fontSize: 0.01),
                    contentPadding: const EdgeInsets.only(
                        left: 25, top: 10, bottom: 10, right: 10),
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: InputBorder.none,
                  ),
                  focusNode: _focusGender,
                  onChanged: (value) {
                    gender = value as String?;
                  },
                ),
        ),
      ],
    );
  }
}

Widget formItem(
    BuildContext context,
    bool readOnly,
    TextEditingController? controller,
    String? initialValue,
    TextInputType? inputType,
    IconData icon,
    double iconSize,
    String? Value,
    String? Type,
    VoidCallback onTap) {
  String? hintText(String? inputType) {
    if (inputType == "fname")
      return "First Name";
    else if (inputType == "lname")
      return "Last Name";
    else if (inputType == "email")
      return "Email Address";
    else if (inputType == "occupation")
      return "Occupation";
    else if (inputType == "birthDate") return "Birthdate";
  }

  return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      keyboardType: inputType,
      decoration: InputDecoration(
          hintText: hintText(Type),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorStyle: TextStyle(fontSize: 0.01),
          contentPadding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
          fillColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            icon,
            size: iconSize,
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
        if (Type == "fname") {
          if (value != null && value.length < 3) {
            fnameError =
                "Please enter your first name (Minimum of 3 characters)";
            return fnameError;
          } else {
            fnameError = null;
            return null;
          }
        } else if (Type == "lname") {
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
        } else if (Type == "email") {
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
        } else if (Type == "occupation") {
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
      }));
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

Widget errorMessage(String? fnameError) {
  return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 5, left: 2),
      child: Text(
        fnameError.toString(),
        style: const TextStyle(color: Colors.red),
      ));
}
