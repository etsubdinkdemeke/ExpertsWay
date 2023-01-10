import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'box.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Box(
              icon: FontAwesomeIcons.arrowLeft,
              size: 20,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            )
          ]),
          Box(
            icon: FontAwesomeIcons.search,
            size: 20,
          )
        ],
      ),
    );
  }
}
