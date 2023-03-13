import 'dart:ffi';
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
import 'package:get/get.dart';
import '../../db/course_database.dart';
import '../../models/course.dart';
import '../../models/notification.dart';

class LessonPage extends StatefulWidget {
  final List<LessonElement?> lessonData;
  final List<LessonContent?> contents;
  final String section;
  final String lesson;
  final String lessonId;
  final String courseId;
  const LessonPage({
    super.key,
    required this.section,
    required this.lesson,
    required this.lessonData,
    required this.contents,
    required this.lessonId,
    required this.courseId,
  });

  @override
  State<LessonPage> createState() => _LessonState();
}

class _LessonState extends State<LessonPage> {
  static ProgressElement? progressElement;
  static CourseElement? courseElement;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
    getLeContents();
    getContentsId();
    getCourseNameandIcon();
    refreshProgress();
  }

  Future<void> getCourseNameandIcon() async {
    courseElement = await CourseDatabase.instance
        .readCourseNameandIcon(int.parse(widget.courseId));
  }

  Future addNotification() async {
    await getCourseNameandIcon();

    NotificationElement notElem = NotificationElement(
      heighlightText: courseElement!.name,
      imgUrl: courseElement!.icon,
      type: 'finishedCourse',
      createdDate: DateTime.now(),
    );
    await CourseDatabase.instance.createNotification(notElem);
  }

  static int getPageNum() {
    int val = progressElement!.pageNum;
    return val;
  }

  Future<void> addOrupdateProgress() async {
    if (progressElement != null) {
      await updateProgress();
    } else {
      await addProgress();
    }
  }

  Future addProgress() async {
    progressElement = ProgressElement(
        progId: null,
        courseId: widget.courseId,
        lessonId: widget.lessonId,
        contentId: getContentID[index].toString(),
        pageNum: index,
        userProgress: getUserProgress().toString());
    await CourseDatabase.instance.createProgress(progressElement!);
  }

  Future updateProgress() async {
    final progress = progressElement!.copy(
      contentId: getContentID[index].toString(),
      pageNum: index,
      userProgress: getUserProgress().toString(),
    );
    String res = await CourseDatabase.instance.updateProgress(progress);
  }

  Future refreshProgress() async {
    setState(() => isLoading = true);
    // getContentID[index].toString()
    progressElement = await CourseDatabase.instance.readProgress(
      widget.courseId,
      widget.lessonId,
    );
    if (progressElement != null) {
      setState(() {
        index = progressElement!.pageNum;
      });
    } else {
      setState(() {
        index = 0;
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    progressElement = null;
    getContent.clear();
    getContentID.clear();
  }

  int index = 0;
  final getContent = [];
  final getContentID = [];
  final getContentLessonId = [];

  getLeContents() {
    for (var i = 0; i < widget.contents.length; i++) {
      var val = widget.contents[i];
      getContent.add(val!.content);
    }
  }

  getContentsId() {
    for (var val in widget.contents) {
      getContentID.add(val!.id);
    }
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

  bool finishLesson = false;
  String nextLessonTitle = "";
  bool showFlushbar = true;
  String? name;

  @override
  Widget build(BuildContext context) {
    // We don't need lessonHtml any more: becouse we use getContent (which is data retrive from database)

    // final lessonHtml =
    //     lessonContent(widget.lessonData, widget.lesson, widget.section);
    nextLesson(widget.lessonData, widget.lesson, widget.section);
    // String lesson = lessonHtml[index];
    String lesson = getContent[index];
    // double progress = index / lessonHtml.length;
    double progress = index / getContent.length;
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
                onPressed: () async {
                  // showFlushbar && index == lessonHtml.length - 1
                  if (showFlushbar && index == getContent.length - 1) {
                    await addNotification();
                    Flushbar(
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                      titleSize: 20,
                      messageSize: 17,
                      backgroundColor: maincolor,
                      borderRadius: BorderRadius.circular(8),
                      title: lessonFinished()[0].toString(),
                      message: lessonFinished()[1].toString(),
                      duration: const Duration(seconds: 5),
                    ).show(context);
                  } else {
                    index < getContent.length - 1
                        ? setState(() {
                            index++;
                          })
                        : setState(() {
                            finishLesson = true;
                            showFlushbar = false;
                          });

                    await addOrupdateProgress();
                    refreshProgress();
                  }
                })
          ],
        ),
      ),
    );
  }

  double getUserProgress() {
    double status = (index * 100) / getContent.length;
    return status;
  }
}
