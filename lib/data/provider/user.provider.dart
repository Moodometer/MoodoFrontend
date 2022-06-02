import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moodometer/data/models/user.model.dart';

class UserDataProvider {
  String baseurl = 'https://jsonplaceholder.typicode.com/users';
  Dio dio = Dio();

  Future getUser() async {
    try {
      var response = await dio.get(baseurl);
      log(response.toString());
      return response;
    } catch (e) {
      return e;
    }
  }
}
