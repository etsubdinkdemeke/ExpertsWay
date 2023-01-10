import 'package:dio/dio.dart';
import 'package:learncoding/models/course.dart';
import 'package:learncoding/utils/constants.dart';

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
}
