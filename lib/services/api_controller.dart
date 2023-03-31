import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expertsway/models/course.dart';
import 'package:expertsway/models/lesson.dart';
import 'package:expertsway/models/user_account.dart';
import 'package:expertsway/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../api/shared_preference/shared_preference.dart';

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

  Future<String> registerUser(String email, String firstname, String lastname, String password, String register_with) async {
    String res = "Some error is occured";
    http.Response? response;
    print("successlly registertedasdf");
    print("register_with");
    print(register_with);

    try {
      // UserAccount userAccount =
      //     UserAccount(registed_with: register_with, email: email, firstname: firstname, lastname: lastname, password: password);

      String password_param = "password";
      String first_name_param = "first_name";
      String last_name_param = "last_name";
      if (register_with == "google") {
        password_param = "google_user_id";
        first_name_param = "given_name";
        last_name_param = "family_name";
      }
      response = await http.post(Uri.parse(AppUrl.userregisterUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "registed_with": register_with, //"email_password",
            "email": email,
            first_name_param: firstname,
            last_name_param: lastname,
            password_param: password
          }));

      if (response.statusCode == 200) {
        res = "success";

        if (register_with == "google") {
          var userInfo = jsonDecode(response.body.toString());
          String? image = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
          if (userInfo['image'] != null) {
            image = userInfo['image'];
          }
          UserPreferences.setuser(
              image!, userInfo['username']!, userInfo['first_name'],
              userInfo['last_name']);
        }
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

  Future<String> loginUser(String email, String password, String login_with) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      response = await http.post(Uri.parse(AppUrl.loginUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'username': email,
            'password': password,
            'login_with': login_with,
          },
          body: jsonEncode(<String, dynamic>{}));
      if (response.statusCode == 200) {
        res = "success";
        var userInfo = jsonDecode(response.body.toString());

        String? image = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
        if (userInfo['image'] != null) {
          image = userInfo['image'];
        }

        UserPreferences.setuser(image!, userInfo['username']!, userInfo['first_name'], userInfo['last_name']);
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

  Future<String> sendInstraction(String email) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      response = await http.post(Uri.parse(AppUrl.sendInstraction),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"user_login": email}));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception catch (e) {
      print(e.toString());
      // res = "Some error is occured";
    }

    return res;
  }

  Future<String> setnewpassword(String email, String newpass, int code) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      response = await http.post(Uri.parse(AppUrl.setnewpassword),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"email": email, "password": newpass, "code": code}));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception catch (e) {
      print(e.toString());
      // res = "Some error is occured";
    }

    return res;
  }
}
