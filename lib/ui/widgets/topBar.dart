import 'package:flutter/material.dart';
import 'package:learncoding/models/user.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/services/api_controller.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:learncoding/ui/pages/course_detail.dart';
import 'package:learncoding/ui/widgets/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/shared_preference/shared_preference.dart';
import '../../db/course_database.dart';
import '../../utils/color.dart';
import 'course_card.dart';

String? name;
String? image;

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
    required this.controller,
    required this.expanded,
    required this.onMenuTap,
  }) : super(key: key);

  final TextEditingController controller;
  final bool expanded;
  final onMenuTap;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int tab = 0;
  late List<CourseElement?> course = [];
  late List<Section> section = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getValue();
    refreshCourse();
  }

  Future refreshCourse() async {
    setState(() => isLoading = true);

    course = await CourseDatabase.instance.readAllCourse();
    setState(() => isLoading = false);
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    name = prefs.getString('name');
    image = prefs.getString('image');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      width: MediaQuery.of(context).size.width,
      height: widget.expanded
          ? MediaQuery.of(context).size.height * 0.35
          : MediaQuery.of(context).size.height * 0.19,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Hi," + name!,
                    style: TextStyle(
                        color: Color(0xFF343434),
                        fontSize: 24,
                        fontWeight: material.FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    child: material.CircleAvatar(
                      backgroundImage: NetworkImage(image!),
                    ),
                    onTap: widget.onMenuTap,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: material.Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      offset: Offset(0, 10),
                      color: Color(0x1A636363),
                    ),
                  ]),
              padding: EdgeInsets.all(10),
              style: TextStyle(
                color: Color(0xFF343434),
                fontSize: 18,
              ),
              enableInteractiveSelection: true,
              controller: widget.controller,
              expands: false,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
              keyboardType: TextInputType.text,
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  BoxIcons.bx_search,
                  color: Color(0xFFADADAD),
                ),
              ),
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.words,
              placeholder: "Search",
              placeholderStyle: TextStyle(
                color: Color(0xFFADADAD),
                fontSize: 18,
              ),
            ),
          ),
          widget.expanded
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.165,
                  child: course.isEmpty
                      ? FutureBuilder<Course>(
                          future: ApiProvider().retrieveCourses(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: maincolor,
                                  ),
                                );
                              }
                            }
                            if (snapshot.hasData) {
                              for (var i = 0;
                                  i < snapshot.data!.courses.length;
                                  i++) {
                                final courseData = snapshot.data!.courses[i];
                                CourseDatabase.instance
                                    .createCourses(courseData);
                              }
                            } else if (snapshot.data!.courses.isEmpty) {
                              return const Center(
                                  child: Text(
                                "There is no Course",
                                style: TextStyle(
                                    color: Color.fromARGB(184, 138, 138, 138)),
                              ));
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text(
                                "Unabel to get the data",
                                style: TextStyle(
                                    color: Color.fromARGB(184, 138, 138, 138)),
                              ));
                            } else if (!snapshot.hasData) {
                              return const Center(
                                  child: Text(
                                "Unabel to get the data",
                                style: TextStyle(
                                    color: Color.fromARGB(184, 138, 138, 138)),
                              ));
                            }

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              refreshCourse();
                            });
                            return Container();
                          })
                      : buildCard())
              : Container(),
        ],
      ),
    );
  }

  Widget buildCard() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: course.length,
      itemBuilder: (context, index) {
        return CourseCard(courses: course[index]!, index: index);
      },
    );
  }

  Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF$color"));
    } else if (color.length == 8) {
      return Color(int.parse("0x$color"));
    } else {
      return const Color.fromARGB(0, 247, 86, 0);
    }
  }
}
