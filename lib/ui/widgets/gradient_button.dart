import 'package:flutter/material.dart';

class GradientBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String btnName;
  String iconUrl;
  bool whiteBtn;
  final bool defaultBtn;
  double height;
  double? width;

  GradientBtn({
    Key? key,
    required this.onPressed,
    required this.btnName,
    this.iconUrl = 'https://cdn-icons-png.flaticon.com/512/6062/6062646.png',
    this.whiteBtn = true,
    required this.defaultBtn,
    this.height = 44,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: whiteBtn ? Colors.white : null,
          gradient: whiteBtn
              ? null
              : const LinearGradient(
                  colors: [Color(0xff2686FF), Color(0xff26B0FF)]),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!defaultBtn)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  iconUrl,
                  height: 32,
                  width: 32,
                ),
              ),
            Text(
              btnName,
              style: TextStyle(
                color: onPressed == null
                    ? Colors.grey
                    : whiteBtn
                        ? Colors.black
                        : Colors.white,
                fontSize: defaultBtn ? 18 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
