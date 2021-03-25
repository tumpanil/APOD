import 'dart:convert';

import 'package:dio/dio.dart';

abstract class APIClient {
  final String url = "https://api.nasa.gov/planetary/apod";
  final String apiKey = "aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw";

  fetch(String url, Dio dio) async {
    print("Url is $url");
    final response = await dio.get(url);
    print("response : $response");
    print(response.data);
    print("code : ${response.statusCode}");
    if (response.statusCode != 200)
      throw Exception(json.decode(response.data)["msg"]);
    return response.data;
  }
}
