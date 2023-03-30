import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expertsway/routes/page.dart';
import 'package:expertsway/utils/color.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../routes/routing_constants.dart';
import '../services/api_controller.dart';
import '../ui/widgets/gradient_button.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController pin1 = TextEditingController();
  final TextEditingController pin2 = TextEditingController();
  final TextEditingController pin3 = TextEditingController();
  final TextEditingController pin4 = TextEditingController();
  final TextEditingController pin5 = TextEditingController();

  final List<int> otp = [];
  @override
  void dispose() {
    super.dispose();
    pin1.dispose();
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
    pin5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Material(
          child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Text("We've sent you an email with \n your verification code",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  SizedBox(height: 40),
                  Text("Check Your Email", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ]),
              ),
              SizedBox(height: 30),
              buildInput(),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Didn't receive anything,", style: TextStyle(color: Colors.black)),
                TextSpan(text: "  send again", style: TextStyle(color: maincolor)),
              ])),
              SizedBox(height: 60),
              GradientBtn(
                onPressed: verify,
                btnName: 'Verify',
                defaultBtn: true,
                isPcked: false,
                width: 280,
                height: 52,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildInput() {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context, color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(10));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 57,
            width: 54,
            child: TextFormField(
              controller: pin1,
              cursorColor: maincolor,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                  enabledBorder: inputBorder,
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: maincolor, width: 2))),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1) {
                  otp.insert(0, int.parse(pin1.text));
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          SizedBox(
            height: 57,
            width: 54,
            child: TextFormField(
              controller: pin2,
              cursorColor: maincolor,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: inputBorder,
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: maincolor, width: 2))),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1) {
                  otp.insert(1, int.parse(pin2.text));
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          SizedBox(
            height: 57,
            width: 54,
            child: TextFormField(
              controller: pin3,
              cursorColor: maincolor,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: inputBorder,
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: maincolor, width: 2))),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1) {
                  otp.insert(2, int.parse(pin3.text));
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          SizedBox(
            height: 57,
            width: 54,
            child: TextFormField(
              controller: pin4,
              cursorColor: maincolor,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: inputBorder,
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: maincolor, width: 2))),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1) {
                  otp.insert(3, int.parse(pin4.text));
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          SizedBox(
            height: 57,
            width: 54,
            child: TextFormField(
              controller: pin5,
              cursorColor: maincolor,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  enabledBorder: inputBorder,
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: maincolor, width: 2))),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1) {
                  otp.insert(4, int.parse(pin5.text));
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future verify() async {
    if (otp.length > 4) {
      int code = int.parse(otp.join(''));
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(color: maincolor),
              ));

      String res = await ApiProvider().verification(email, code);
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
    } else {
      return null;
    }
  }
}
