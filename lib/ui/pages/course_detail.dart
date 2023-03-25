import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/models/lesson.dart' as lesson;
import 'package:learncoding/ui/pages/lesson.dart';
import 'package:learncoding/services/api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncoding/theme/config.dart' as config;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';

import '../../db/course_database.dart';
import '../../models/lesson.dart';
import '../../utils/color.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseElement courseData;

  const CourseDetailPage({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  CoursePagePageState createState() => CoursePagePageState();
}

class CoursePagePageState extends State<CourseDetailPage> {
  late List<List> lessonData = [];
  late List<LessonContent> lessoncontent = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLesson();
  }

  Future refreshLesson() async {
    setState(() => isLoading = true);
    var lessonDataUnprocessed =
        await CourseDatabase.instance.readLesson(widget.courseData.slug);

    lessonData = lessonDataUnprocessed.map((e) => [e, false]).toList();
    if (kDebugMode) {
      print("....lesson length ....${lessonData.length}");
    }
    applyProgressOnLessons();
    setState(() => isLoading = false);
  }

  Future applyProgressOnLessons() async {
    CourseProgressElement? courseProgress = await CourseDatabase.instance
        .readCourseProgress(widget.courseData.courseId.toString());
    if (courseProgress != null) {
      for (int i = 0; i < courseProgress.lessonNumber; i++) {
        lessonData[i][1] = true;
      }
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> sectionList(List<List> lessonData) {
    var seen = <String>[];
    for (var element in lessonData) {
      seen.add(element[0].section as String);
    }
    final sectionList = seen.toSet().toList();
    return sectionList;
  }

  List<List> lessonList(List<List> lessonData, String section) {
    var seen = <List>[];
    for (var element in lessonData) {
      if (element[0].section == section) {
        seen.add(element);
      }
    }
    return seen;
  }

  Widget buildCoverImage() {
    // this mehtod builds the cover image and the texts
    // on it (displayed at the top of the course-detail screen)
    return Stack(
      // we use this stack to display the course name and chapters on top of the cover image.
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.4,

          // ignore: unnecessary_null_comparison
          child: widget.courseData != null
              ? Image.network(
                  widget.courseData.banner,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ), // TODO: replace this url with real course specific data
        ),
        Positioned(
          bottom: 5,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.courseData.name,
                    // TODO: consider color contrast issues here.
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    // we're considering the lessons to be the "chapters"
                    "${lessonData.length} Chapters",
                    // TODO: consider color contrast issues here.
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: SizedBox(
            height: 40,
            width: 40,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Material(
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  iconSize: 14,
                  constraints:
                      const BoxConstraints(maxHeight: 60, maxWidth: 60),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.Colors().secondColor(1),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height + 60,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildCoverImage(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 4),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: const <Widget>[
                              Text(
                                "Description",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontSize: 14),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              widget.courseData.description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Color(0xFF343434),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            children: const <Widget>[
                              Text(
                                "Select chapter",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 138, 138, 138),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Builder(builder: (context) {
                      return lessonData.isEmpty
                          ? FutureBuilder<Lesson>(
                              future: ApiProvider()
                                  .retrieveLessons(widget.courseData.slug),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: maincolor,
                                      ),
                                    );
                                  }
                                }
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: Text(
                                    "There is no Course",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(184, 138, 138, 138)),
                                  ));
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                      child: Text(
                                    "Unable to get the data",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(184, 138, 138, 138)),
                                  ));
                                }
                                if (snapshot.hasData) {
                                  for (var i = 0;
                                      i < snapshot.data!.lessons.length;
                                      i++) {
                                    final fetchedLesson =
                                        snapshot.data!.lessons[i];
                                    CourseDatabase.instance
                                        .createLessons(fetchedLesson!);
                                  }

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    refreshLesson();
                                  });
                                }

                                return Container();
                              })
                          : buildLessonGroups();
                      // buildUniformLessonList();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildLessonGroups() {
    var sections = sectionList(lessonData);
    return Column(
      children: [
        for (int i = 0; i < sections.length; i++)
          Builder(builder: (context) {
            var lessonsUnderSection = lessonList(lessonData, sections[i]);

            return ConfigurableExpansionTile(
              header: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          sections[i],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        color: Colors.grey[300],
                        width: MediaQuery.of(context).size.width - 36,
                        height: 1,
                      )
                    ],
                  ),
                ),
              ),
              headerExpanded: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          sections[i],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width - 36,
                        height: 4,
                      )
                    ],
                  ),
                ),
              ),
              childrenBody: Column(
                children: [
                  for (int j = 0; j < lessonsUnderSection.length; j++)
                    GestureDetector(
                      onTap: (lessonsUnderSection[j][
                              1]) // only the very first lesson will be unlocked
                          ? () async {
                              var lessonContents = await CourseDatabase.instance
                                  .readLessonContets(
                                      lessonsUnderSection[j][0].lessonId);
                              // again, we're making the very last lesson locked.
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => LessonPage(
                                    lessonData: lessonData,
                                    lesson: lessonsUnderSection[j][0],
                                    contents: lessonContents,
                                    courseData: widget.courseData,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: ListTile(
                        title: Text(
                          lessonsUnderSection[j][0].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          lessonsUnderSection[j][0].shortDescription.isNotEmpty
                              ? lessonsUnderSection[j][0].shortDescription
                              : "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It's also called placeholder (or filler) text.",
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: (lessonsUnderSection[j][1])
                            ? Builder(
                                builder: (_) {
                                  // we're generating a lot of random booleans here for demonstration purposes
                                  // all these boolean flags should be received from the database or API in the future.
                                  // TODO: change the following code to make it work with real data
                                  var isLessonCompleted = Random().nextBool();
                                  if (isLessonCompleted) {
                                    var testResult = Random().nextInt(101);
                                    return CircleAvatar(
                                      radius: 20,
                                      foregroundColor: Colors.white,
                                      backgroundColor: testResult > 60
                                          ? Colors.green[300]
                                          : (testResult > 30
                                              ? Colors.yellow[400]
                                              : Colors.red[300]),
                                      child: Text(testResult.toString()),
                                    );
                                  } else {
                                    var progress = Random()
                                        .nextDouble(); // how much the user has progressed with the lesson
                                    // the widget below is from a 3rd party package named 'percent indicator'. check it out on 'pub.dev'
                                    return CircularPercentIndicator(
                                      radius: 20,
                                      lineWidth: 3,
                                      percent: progress,
                                      progressColor: Colors.blue,
                                    );
                                  }
                                },
                              )
                            : CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.blue[50],
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            );
          }),
      ],
    );
  }
}
