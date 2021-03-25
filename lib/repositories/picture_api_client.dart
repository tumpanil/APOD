import 'package:apod/model/picture_data.dart';
import 'package:apod/repositories/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PictureAPIClient extends APIClient {
  final Dio dio;
  final String date;

  PictureAPIClient({@required this.date, @required this.dio})
      : assert(dio != null);

  Future<PictureData> getPictureDetails() async {
    String finalUrl = "$url?api_key=$apiKey&date=$date";
    final response = await fetch(finalUrl, dio);
    return PictureData.fromJson(response);
  }
}
