// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncoding/db/course_database.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/services/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageController extends GetxController {
  RxList<CourseElement> course = <CourseElement>[].obs;

  String? profileName = '';
  String? profileImage = '';

  final loading = false.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    getCourses();
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
      loading.value = false;
    } catch (e) {
      Get.log(e.toString());
    }
  }

  // get  user profile
  Future getProfileDetails() async {
    final result = await SharedPreferences.getInstance();
    profileName = result.getString('name');
    profileImage = result.getString('image');
  }
}
