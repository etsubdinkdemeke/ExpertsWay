import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/models/lesson.dart';
import 'package:learncoding/models/user_account.dart';
import 'package:learncoding/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<Course> retrieveCourses() async {
    var dio = Dio();
    Response response = await dio.get(
      AppUrl.courseUrl,
      queryParameters: {'last_updated': '2020-10-14 06:48:28'},
      options: Options(
        headers: {
          'username': AppUrl.username,
          'password': AppUrl.password,
          'login_with': AppUrl.loginWith,
        },
      ),
    );
    if (response.statusCode == 200) {
      final responseBody = response.data;
      final Course course = courseFromJson(responseBody);
      return course;
    } else {
      throw Exception('Failed to load course');
    }
  }

  Future<Lesson> retrieveLessons(slug) async {
    var dio = Dio();
    Response response = await dio.get(
      '${AppUrl.lessonUrl}/$slug',
      queryParameters: {'post_modified': '2021-10-30 13:28:40'},
      options: Options(
        headers: {
          'username': AppUrl.username,
          'password': AppUrl.password,
          'login_with': AppUrl.loginWith,
        },
      ),
    );
    if (response.statusCode == 200) {
      final responseBody = response.data;
      final lesson = lessonFromJson(responseBody);
      return lesson;
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  Future<String> registerUser(
    String email,
    String firstname,
    String lastname,
    String password,
  ) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      UserAccount userAccount =
          UserAccount(registed_with: "email_password", email: email, firstname: firstname, lastname: lastname, password: password);

      response = await http.post(Uri.parse(AppUrl.userregisterUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "registed_with": "email_password",
            "email": email,
            "first_name": firstname,
            "last_name": lastname,
            "password": password
          }));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return res;
  }

  Future<String> verification(
    String email,
    int otp,
  ) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      response = await http.post(Uri.parse(AppUrl.activateaccount),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"email": email, "code": otp}));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception catch (e) {
       res = "Some error is occured";
    }

    return res;
  }

  Future<String> loginUser(
    String email,
    String password,
  ) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
     response = await http.post(Uri.parse(AppUrl.loginUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'username': email,
            'password': password,
            'login_with': 'email_password',
          },
          body: jsonEncode(<String, dynamic>{}));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception catch (e) {
      res = "Some error is occured";
    }

    return res;
  }
}
