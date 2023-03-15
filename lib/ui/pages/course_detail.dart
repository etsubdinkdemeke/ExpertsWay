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
  late List<LessonElement> lessonData = [];
  late List<LessonContent> lessoncontent = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLesson();
  }

  Future refreshLesson() async {
    setState(() => isLoading = true);
    lessonData =
        await CourseDatabase.instance.readLesson(widget.courseData.slug);
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

  List sectionList(lessonData) {
    var seen = [];
    for (var lesson in lessonData) {
      seen.add(lesson.section);
    }
    final sectionList = seen.toSet().toList();
    return sectionList;
  }

  List lessonList(lessonData, section) {
    var seen = [];
    for (var lesson in lessonData) {
      if (lesson.section == section) {
        seen.add(lesson.title);
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

  Widget buildlesson() {
    // Currently, this method is not used. But I didn't want to remove it 'cause
    // there's a lot of effort put in making this. I chose to keep it just in case ...
    return FutureBuilder<lesson.Lesson>(
        future: ApiProvider().retrieveLessons(widget.courseData.slug),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lessonData = snapshot.data!.lessons;
            List sections = sectionList(lessonData);
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Text(
                    "Lessons",
                    style: TextStyle(color: Color(0xFF343434), fontSize: 24),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.865,
                  margin: const EdgeInsets.only(bottom: 70),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 215, 214, 214),
                    ),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildLessonList(lessonData, sections[index]),
                            index < sections.length
                                ? const Divider(
                                    color: Color.fromARGB(255, 215, 214, 214),
                                    thickness: 1,
                                    height: 1,
                                  )
                                : Container()
                          ],
                        );
                      }),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  List lessonListId(lessonData, section) {
    // Currently, this method is not used. But I didn't want to remove it 'cause
    // there's a lot of effort put in making this. I chose to keep it just in case ...
    var id = [];
    for (var lesson in lessonData) {
      if (lesson.section == section) {
        id.add(lesson.lessonId);
      }
    }
    return id;
  }

  Widget buildLessonList(lessonData, section) {
    // Currently, this method is not used. But I didn't want to remove it 'cause
    // there's a lot of effort put in making this. I chose to keep it just in case ...
    return Material(
      color: config.Colors().secondColor(1),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: const Color.fromARGB(0, 208, 57, 57),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 172, 172, 172),
            size: 35,
          ),
        ),
        child: ExpansionTile(
          title: Flexible(
            child: Text(
              section,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 121, 121, 123),
              ),
            ),
          ),
          tilePadding: const EdgeInsets.fromLTRB(15, 1, 10, 1),
          iconColor: const Color.fromARGB(255, 172, 172, 172),
          collapsedIconColor: const Color.fromARGB(255, 172, 172, 172),
          children: <Widget>[
            const Divider(
              color: Color.fromARGB(255, 215, 214, 214),
              thickness: 1,
              height: 1,
            ),
            const SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: null == lessonData
                    ? 0
                    : lessonList(lessonData, section).length,
                itemBuilder: (context, index) {
                  List lessonTitle = lessonList(lessonData, section);
                  return Container(
                    padding: const EdgeInsets.fromLTRB(17, 0, 15, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle_outlined,
                                size: 25,
                                color: index <= 2 ? Colors.blue : Colors.grey),
                            const SizedBox(
                              width: 17,
                            ),
                            GestureDetector(
                              child: Text(
                                lessonTitle[index],
                                style: TextStyle(
                                  color: index == 2 ? Colors.blue : Colors.grey,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () async {
                                List lessonIds =
                                    lessonListId(lessonData, section);
                                String lessonIndex =
                                    (lessonIds[index]).toString();

                                lessoncontent = await CourseDatabase.instance
                                    .readLessonContets(lessonIds[index]);
                                if (lessoncontent.isNotEmpty) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => LessonPage(
                                        lessonData: lessonData,
                                        contents: lessoncontent,
                                        section: section.toString(),
                                        lessonId: lessonIndex,
                                        lesson: lessonTitle[index].toString(),
                                        courseData: widget.courseData,
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 12),
                            alignment: Alignment.topLeft,
                            child: index < lessonTitle.length - 1
                                ? Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.grey,
                                  )
                                : Container())
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildLessonCard() {
    // Currently, this method is not used. But I didn't want to remove it 'cause
    // there's a lot of effort put in making this. I chose to keep it just in case ...
    List sections = sectionList(lessonData);

    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildLessonList(lessonData, sections[index]),
              index < sections.length
                  ? const Divider(
                      color: Color.fromARGB(255, 215, 214, 214),
                      thickness: 1,
                      height: 1,
                    )
                  : Container()
            ],
          );
        });
  }

  Widget buildUniformLessonList() {
    return Material(
      color: config.Colors().secondColor(1),
      child: Column(
        children: <Widget>[
          for (var index = 0; index < lessonData.length; index++)
            Column(
              children: [
                GestureDetector(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      lessonData[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // TODO: change the dummy subtitle with a real one (once we can get the lesson contents along with the lessons from the database)
                    subtitle: Text(
                      lessonData[index].shortDescription.isNotEmpty
                          ? lessonData[index].shortDescription
                          : "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It's also called placeholder (or filler) text.",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: index !=
                            lessonData.length - 1 // we're making only the very
                        // last lesson locked. (b/c, for now, we want to display what a locked
                        // lesson looks like. we'll change this when we have data about the
                        // progress of the user. the user progress will determine which lessons
                        // are open and which are locked.)
                        ? Builder(builder: (_) {
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
                          })
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
                  onTap: () async {
                    var lessonContents = await CourseDatabase.instance
                        .readLessonContets(lessonData[index].lessonId);
                    if (lessonContents.isNotEmpty &&
                        index != lessonData.length - 1) {
                      // again, we're making the very last lesson locked.
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LessonPage(
                            lessonData: lessonData,
                            lesson: lessonData[index]
                                .title, // please don't be mad with the namings ... X(
                            contents: lessonContents,
                            courseData: widget.courseData,
                            lessonId: lessonData[index].lessonId.toString(),
                            section: lessonData[index].section,
                          ),
                        ),
                      );
                    }
                  },
                ),
                Divider(
                  color: Colors.grey[400],
                )
              ],
            )
        ],
      ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: <Widget>[
                              const Text(
                                "Description",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontSize: 14),
                              ),
                              const Spacer(),
                              CupertinoButton(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.comment_outlined,
                                  size: 20,
                                ),
                                onPressed:
                                    () {}, // TODO: implement this method: showing comments for this course
                              ),
                              CupertinoButton(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.bookmark_outline,
                                  size: 20,
                                ),
                                onPressed:
                                    () {}, // TODO: implement this method: bookmarking this course
                              )
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
                                    refreshLesson();
                                  });
                                }

                                return Container();
                              })
                          : buildUniformLessonList();
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
}
