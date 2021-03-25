import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PictureData extends Equatable {
  final String url;
  final String title;
  final String explanation;
  final String date;

  const PictureData({
    @required this.date,
    @required this.title,
    @required this.url,
    @required this.explanation,
  });

  @override
  List<Object> get props => [url, title, explanation, date];

  static PictureData fromJson(dynamic json) {
    return PictureData(
      date: json["date"],
      title: json["title"],
      url: json["url"],
      explanation: json["explanation"],
    );
  }
}
