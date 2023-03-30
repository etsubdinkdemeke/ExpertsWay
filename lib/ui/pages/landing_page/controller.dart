// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncoding/db/course_database.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/services/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageController extends GetxController {
  RxList<CourseElement> course = <CourseElement>[].obs;
  RxList<CourseElement> userCourses = <CourseElement>[].obs; // these are the courses the user has started learning
  RxList<CourseProgressElement> progressList = <CourseProgressElement>[].obs;

  String? profileName = '';
  String? profileImage = '';

  final loading = false.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    course.isEmpty ? getCourses() : getCoursesFromDatabase();

    getProfileDetails();

    super.onInit();
  }

  Future getCourses() async {
    try {
      loading.value = true;
      final crs = await CourseDatabase.instance.readAllCourse();

      //Get the course from api
      final results = await ApiProvider().retrieveCourses();

      if (results.courses.isNotEmpty) {
        // insert the courses to local database
        for (var course in results.courses) {
          if (crs.isNotEmpty) {
            crs.map((element) {
              if (element != course) {
                CourseDatabase.instance.createCourses(course);
              }
            });
          } else {
            CourseDatabase.instance.createCourses(course);
          }
        }
      }

      getCoursesFromDatabase();

      loading.value = false;
    } catch (e) {
      Get.log(e.toString());
    }
  }

  //fetch the course from local database
  Future getCoursesFromDatabase() async {
    try {
      loading.value = true;
      course.value = await CourseDatabase.instance.readAllCourse();
      await getProgressListFromDatabase();
      updateUserCourses();
      loading.value = false;
    } catch (e) {
      Get.log(e.toString());
    }
  }

  Future getProgressListFromDatabase() async {
    try {
      loading.value = true;
      progressList.value = await CourseDatabase.instance.readAllCourseProgress();
      loading.value = false;
    } catch (e) {
      Get.log(e.toString());
    }
  }

  void updateUserCourses() {
    userCourses.clear();
    for (var element in course) {
      for (var progress in progressList) {
        if (progress.courseId == element.courseId?.toString()) {
          userCourses.add(element);
          break;
        }
      }
    }
  }

  // get  user profile
  Future getProfileDetails() async {
    final result = await SharedPreferences.getInstance();
    profileName = result.getString('name');
    profileImage = result.getString('image');
  }
}
