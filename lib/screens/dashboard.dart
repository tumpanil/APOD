import 'package:apod/bloc/picture_bloc.dart';
import 'package:apod/repositories/picture_api_client.dart';
import 'package:apod/repositories/picture_repository.dart';
import 'package:apod/screens/detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatelessWidget {
  final String date;

  const DashBoard({@required this.date});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Picture of the Day",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                datePicker(context).then((date) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashBoard(date: date),
                      ),
                      (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      body: BlocProvider<PictureBloc>(
        create: (context) => PictureBloc(
          pictureRepository: PictureRepository(
            pictureAPIClient: PictureAPIClient(
              date: date,
              dio: Dio(),
            ),
          ),
        ),
        child:
            BlocBuilder<PictureBloc, PictureState>(builder: (context, state) {
          if (state is InitialState) {
            print("state is $state");
            BlocProvider.of<PictureBloc>(context).add(
              FetchPictureDetailsEvent(),
            );
          } else if (state is DetailsFetchedState) {
            return GestureDetector(
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    title: state.pictureData.title,
                    explanation: state.pictureData.explanation,
                    imageUrl: state.pictureData.url,
                    date: state.pictureData.date,
                  ),
                );
                Navigator.push(context, route);
              },
              child: Stack(
                children: [
                  Image.network(
                    state.pictureData.url,
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          state.pictureData.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.06,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Tap for Details",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Future<String> datePicker(context) async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(
      new FocusNode(),
    );

    date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(
        Duration(days: 0),
      ),
    );

    return DateFormat('yyyy-MM-dd').format(date);
  }
}
