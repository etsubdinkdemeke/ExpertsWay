import 'dart:math' hide log;
import 'dart:developer' show log;

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

import '../../db/course_database.dart' hide courseProgress;
import '../../models/lesson.dart';
import '../../utils/color.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseElement courseData;

  CourseDetailPage({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  CoursePagePageState createState() => CoursePagePageState();
}

class CoursePagePageState extends State<CourseDetailPage> {
  late List<List> lessonData = [];
  late CourseProgressElement courseProgress;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLessonAndProgress();
  }

  Future refreshLessonAndProgress() async {
    setState(() => isLoading = true);
    var data = await CourseDatabase.instance.readLesson(widget.courseData.slug);
    // let's also read the course progress here
    courseProgress = await CourseDatabase.instance
            .readCourseProgress(widget.courseData.courseId!.toString()) ??
        await CourseDatabase.instance.createCourseProgressElement(
          CourseProgressElement(
            courseId: widget.courseData.courseId.toString(),
            lessonNumber: 0,
          ),
        );
    for (int i = 0; i < data.length; i++) {
      // the attached boolean tells if each lesson is locked or open. true means open.
      lessonData.add([data[i], i <= courseProgress.lessonNumber]);
    }
    if (kDebugMode) {
      print("....lesson length ....${lessonData.length}");
    }
    setState(() => isLoading = false);
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
    for (var entry in lessonData) {
      seen.add(entry[0].section as String);
    }
    final sectionList = seen.toSet().toList();
    return sectionList;
  }

  List<List> getLessonsWithSection(List<List> lessonData, String section) {
    var seen = <List>[];
    for (int i = 0; i < lessonData.length; i++) {
      if (lessonData[i][0].section == section) {
        seen.add(lessonData[i]);
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
                                    final lessonData =
                                        snapshot.data!.lessons[i];
                                    CourseDatabase.instance
                                        .createLessons(lessonData!);
                                  }

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    refreshLessonAndProgress();
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
            var lessonsUnderSection =
                getLessonsWithSection(lessonData, sections[i]);

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
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: (lessonsUnderSection[j][
                                1]) // we look at the associated boolean with the lesson to know if it's locked
                            ? () async {
                                var lessonContents = await CourseDatabase
                                    .instance
                                    .readLessonContets(
                                        lessonsUnderSection[j][0].lessonId);
                                // again, we're making the very last lesson locked.
                                // ignore: use_build_context_synchronously
                                bool lessonComplete = await Navigator.push(
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
                                if (lessonComplete) {
                                  unlockNextLesson(lessonsUnderSection[j]);
                                }
                                setState(() {});
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
                            lessonsUnderSection[j][0]
                                    .shortDescription
                                    .isNotEmpty
                                ? lessonsUnderSection[j][0].shortDescription
                                : "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It's also called placeholder (or filler) text.",
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: (lessonsUnderSection[j][
                                  1]) // we look at the associated boolean with the lesson to know if it's locked
                              ? SizedBox(
                                  width: 50,
                                  child: FutureBuilder<ProgressElement?>(
                                    future: CourseDatabase.instance
                                        .readProgress(
                                            widget.courseData.courseId!
                                                .toString(),
                                            lessonsUnderSection[j][0]
                                                .lessonId
                                                .toString()),
                                    builder: (context, snapshot) {
                                      // we're generating a lot of random booleans here for demonstration purposes
                                      // all these boolean flags should be received from the database or API in the future.
                                      // TODO: change the following code to make it work with real data

                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        // the widget below is from a 3rd party package named 'percent indicator'. check it out on 'pub.dev'
                                        return CircularPercentIndicator(
                                          radius: 20,
                                          lineWidth: 3,
                                          percent: double.parse(
                                                  snapshot.data!.userProgress) /
                                              100,
                                          progressColor: Colors.blue,
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return CircularPercentIndicator(
                                          radius: 20,
                                          lineWidth: 3,
                                          percent: 0,
                                          progressColor: Colors.blue,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
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
                      );
                    }),
                ],
              ),
            );
          }),
      ],
    );
  }

  void unlockNextLesson(List lessonEntry) async {
    /// we check if the next lesson is locked. if so, we unlock it by incrementing
    /// the lessonNumber in the course progress
    for (int i = 0; i < lessonData.length - 1; i++) {
      if (lessonData[i][0].lessonId == lessonEntry[0].lessonId) {
        var nextLessonEntry = lessonData[i + 1];
        log("is next lesson locked? : ${nextLessonEntry[1] == false}");
        if (nextLessonEntry[1] == false) {
          // now we know the next lesson is locked. let's unlock it.
          CourseProgressElement newCourseProgress = courseProgress.copy(
            newLessonNumber: courseProgress.lessonNumber + 1,
          );
          await CourseDatabase.instance.updateCourseProgress(newCourseProgress);
          courseProgress = newCourseProgress;
          nextLessonEntry[1] = true;
        }
      }
    }
  }
}
