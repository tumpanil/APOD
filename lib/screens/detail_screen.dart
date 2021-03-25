import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String date;
  final String imageUrl;
  final String title;
  final String explanation;

  const DetailScreen(
      {@required this.title,
      @required this.date,
      @required this.explanation,
      @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Image.network(
            imageUrl,
            height: height * 0.5,
            fit: BoxFit.fill,
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.02,
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.02,
              ),
              child: Text(
                explanation,
                style: TextStyle(fontSize: width * 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
