import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:expertsway/models/course.dart';
import 'package:expertsway/models/lesson.dart' as lesson;
import 'package:expertsway/ui/pages/lesson.dart';
import 'package:expertsway/services/api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:expertsway/theme/config.dart' as config;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:provider/provider.dart';
import '../../theme/theme.dart';

import '../../db/course_database.dart' hide courseProgress;
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
  CourseProgressElement? courseProgress;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLesson();
  }

  Future refreshLesson() async {
    setState(() => isLoading = true);
    var lessonDataUnprocessed = await CourseDatabase.instance.readLesson(widget.courseData.slug);
    // we temporarily set all lessons as locked. if there is a progress on this
    // course, some of the lessons will be unlocked later when the progress is read from database.
    lessonData = lessonDataUnprocessed.map((e) => [e, false]).toList();
    lessonData[0][1] = true; // even if there's no progress, we want the first lesson open.
    if (kDebugMode) {
      print("....lesson length ....${lessonData.length}");
    }
    // here we're reading the progress and applying it on the lessons if it exists
    // (applying it on lessons means setting some locked and some unlocked based on the progress)
    CourseDatabase.instance.readCourseProgress(widget.courseData.courseId.toString()).then((value) {
      courseProgress = value;
      applyProgressOnLessons();
    });
    setState(() => isLoading = false);
  }

  Future applyProgressOnLessons() async {
    // here we're applying it on the lessons if it exists
    // (applying it on lessons means setting some locked and some unlocked based on the progress)
    if (courseProgress != null) {
      for (int i = 0; i < courseProgress!.lessonNumber; i++) {
        lessonData[i][1] = true;
      }
      setState(() {});
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
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    // we're considering the lessons to be the "chapters"
                    "${lessonData.length} Chapters",
                    // TODO: consider color contrast issues here.
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              height: 22,
              width: 22,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                padding: EdgeInsets.only(left: 0),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blue),
                iconSize: 14,
                constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: themeProvider.currentTheme == ThemeData.light() ? Colors.white : Color.fromARGB(255, 25, 32, 36),
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
                            children: <Widget>[
                              Text(
                                "Description",
                                style: textTheme.headline1?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
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
                            style: textTheme.headline5?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Select chapter",
                                style: textTheme.headline1?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
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
                              future: ApiProvider().retrieveLessons(widget.courseData.slug),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: maincolor,
                                      ),
                                    );
                                  }
                                }
                                if (!snapshot.hasData) {
                                  return Center(
                                    child:
                                        Text("There is no Course", style: textTheme.headline1?.copyWith(fontSize: 15, fontWeight: FontWeight.w400)),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                    "Unable to get the data",
                                    style: textTheme.headline1?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                  ));
                                }
                                if (snapshot.hasData) {
                                  for (var i = 0; i < snapshot.data!.lessons.length; i++) {
                                    final fetchedLesson = snapshot.data!.lessons[i];
                                    CourseDatabase.instance.createLessons(fetchedLesson!);
                                  }

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
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
    TextTheme textTheme = Theme.of(context).textTheme;
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
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          sections[i],
                          style: textTheme.headline1?.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
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
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          sections[i],
                          style: textTheme.headline1?.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
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
                      onTap: (lessonsUnderSection[j][1]) // only the very first lesson will be unlocked
                          ? () async {
                              var lessonContents = await CourseDatabase.instance.readLessonContets(lessonsUnderSection[j][0].lessonId);
                              // the LessonPage should return a boolean when it pops. (true if the lesson has been complete)
                              // ignore: use_build_context_synchronously
                              var _isLessonFinished = await Navigator.push(
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
                              setState(() {});
                              if (_isLessonFinished) {
                                // we update the progress and unlock the next lesson
                                // if the lesson on the lessonPage has been complete.
                                unlockNextLesson(lessonsUnderSection[j]);
                              }
                            }
                          : null,
                      child: ListTile(
                        title: Text(
                          lessonsUnderSection[j][0].title,
                          style: textTheme.headline1?.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          lessonsUnderSection[j][0].shortDescription.isNotEmpty
                              ? lessonsUnderSection[j][0].shortDescription
                              : "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It's also called placeholder (or filler) text.",
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline5?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: (lessonsUnderSection[j][1])
                            ? SizedBox(
                                width: 40,
                                child: FutureBuilder<ProgressElement?>(
                                  future: CourseDatabase.instance.readProgress(
                                    widget.courseData.courseId!.toString(),
                                    lessonsUnderSection[j][0].lessonId.toString(),
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        throw Exception("Error reading progress from the database");
                                      }
                                      return CircularPercentIndicator(
                                        radius: 20,
                                        lineWidth: 3,
                                        percent: double.parse(snapshot.data?.userProgress ?? "0") / 100,
                                        progressColor: Colors.blue,
                                      );
                                    }
                                    return Container();
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
                    ),
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
        if (nextLessonEntry[1] == false) {
          // now we know the next lesson is locked. let's unlock it.
          if (courseProgress == null) {
            courseProgress = await CourseDatabase.instance
                .createCourseProgressElement(CourseProgressElement(courseId: widget.courseData.courseId.toString(), lessonNumber: 2));
          } else {
            CourseProgressElement newCourseProgress = courseProgress!.copy(
              newLessonNumber: courseProgress!.lessonNumber + 1,
            );
            await CourseDatabase.instance.updateCourseProgress(newCourseProgress);
            courseProgress = newCourseProgress;
          }
          await applyProgressOnLessons();
        }
      }
    }
  }
}
