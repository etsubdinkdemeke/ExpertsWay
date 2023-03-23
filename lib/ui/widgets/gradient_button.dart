import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

// ignore: must_be_immutable
class GradientBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String btnName;
  String iconUrl;
  bool isPcked;
  final bool defaultBtn;
  double borderRadius;
  double height;
  double? width;

  GradientBtn({
    Key? key,
    required this.onPressed,
    required this.btnName,
    this.iconUrl = 'https://cdn-icons-png.flaticon.com/512/6062/6062646.png',
    this.isPcked = true,
    required this.defaultBtn,
    this.borderRadius = 10,
    this.height = 35,
    this.width = 135,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color color = Theme.of(context).cardColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: themeProvider.currentTheme == ThemeData.light()
                    ? Colors.grey.shade300
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(2, 8))
          ],
          color: isPcked ? color : color,
          gradient: isPcked
              ? null
              : const LinearGradient(
                  colors: [Color(0xff2686FF), Color(0xff26B0FF)]),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!defaultBtn)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: CachedNetworkImage(
                  imageUrl: iconUrl,
                  height: 20,
                  width: 20,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text(
                btnName,
                style: textTheme.bodyText2?.copyWith(
                    fontSize: defaultBtn ? 15 : null,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
