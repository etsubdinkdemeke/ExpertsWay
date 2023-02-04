import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:learncoding/api/shared_preference/shared_preference.dart';
import 'package:learncoding/models/lesson.dart';
import 'package:learncoding/models/user.dart';
import 'package:learncoding/theme/box_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncoding/theme/config.dart' as config;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learncoding/utils/color.dart';
import 'package:learncoding/utils/lessonFinishMessage.dart';

class LessonPage extends StatefulWidget {
  final List<LessonElement?> lessonData;
  final String section;
  final String lesson;
  const LessonPage({
    super.key,
    required this.section,
    required this.lesson,
    required this.lessonData,
  });

  @override
  State<LessonPage> createState() => _LessonState();
}

class _LessonState extends State<LessonPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    User user = await UserPreferences.getuser('image', 'name');
    String? name = user.name;
    this.name = name;
  }

  lessonFinished() {
    Random random = Random();
    int randomNo1 = random.nextInt(greeting.length);
    int randomNo2 = random.nextInt(completed.length);
    int randomNo3 = random.nextInt(encouragement.length);

    String message, greet;
    if (greeting[randomNo1].startsWith("Congratulations") ||
        greeting[randomNo2].startsWith("You did it") ||
        greeting[randomNo3].startsWith("Wow")) {
      greet = "${greeting[randomNo1]} $name!";
    } else {
      greet = "${greeting[randomNo1]} $name";
    }

    if (encouragement[randomNo3].endsWith(".") ||
        encouragement[randomNo3].endsWith("!")) {
      message =
          "${completed[randomNo2]}${widget.lesson} in ${widget.section}. ${encouragement[randomNo3]}";
    } else {
      message =
          "${completed[randomNo2]}${widget.lesson} in ${widget.section}. ${encouragement[randomNo3]} $nextLessonTitle in the next chapter.";
    }
    List<String> encouragementMessage = [greet, message];
    return encouragementMessage;
  }

  nextLesson(lessonData, lesson, section) {
    bool lessonFound = false;
    for (var element in lessonData) {
      if (lessonFound) {
        nextLessonTitle = element.title;
        break;
      }
      if (element.title == lesson && element.section == section) {
        lessonFound = true;
      }
    }
  }

  lessonContent(lessonData, lesson, section) {
    for (var element in lessonData) {
      if (element.title == lesson && element.section == section) {
        final lessonHtml = element.content;
        return lessonHtml;
      }
    }
    return null;
  }

  int index = 0;
  bool finishLesson = false;
  String nextLessonTitle = "";
  bool showFlushbar = true;
  String? name;

  @override
  Widget build(BuildContext context) {
    final lessonHtml =
        lessonContent(widget.lessonData, widget.lesson, widget.section);
    nextLesson(widget.lessonData, widget.lesson, widget.section);
    String lesson = lessonHtml[index];
    double progress = index / lessonHtml.length;
    int remainingHearts = 3;
    return CupertinoPageScaffold(
      backgroundColor: config.Colors().secondColor(1),
      navigationBar: CupertinoNavigationBar(
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        padding: const EdgeInsetsDirectional.only(
          start: 0,
          end: 20,
        ),
        previousPageTitle: "Back",
        backgroundColor: config.Colors().secondColor(1),
        leading: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.black87,
            size: 30,
          ),
        ),
        trailing: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                BoxIcons.bxs_heart,
                color: Color.fromARGB(255, 246, 33, 82),
                size: 25,
              ),
              const SizedBox(width: 5),
              Text(
                "$remainingHearts",
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.green,
                  value: finishLesson ? 1 : progress,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 4, 67, 33)),
                  minHeight: 18,
                ),
              ),
            ),
            Html(
              data: lesson,
            ),
            CupertinoButton(
                child: const Text("Next lesson"),
                onPressed: () {
                  showFlushbar && index == lessonHtml.length - 1
                      ? Flushbar(
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                          titleSize: 20,
                          messageSize: 17,
                          backgroundColor: maincolor,
                          borderRadius: BorderRadius.circular(8),
                          title: lessonFinished()[0].toString(),
                          message: lessonFinished()[1].toString(),
                          duration: const Duration(seconds: 5),
                        ).show(context)
                      : Container();
                  index < lessonHtml.length - 1
                      ? setState(() {
                          index++;
                        })
                      : setState(() {
                          finishLesson = true;
                          showFlushbar = false;
                        });
                })
          ],
        ),
      ),
    );
  }
}
