import 'package:apod/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Apod());
}

class Apod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoard(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );
  }
}
