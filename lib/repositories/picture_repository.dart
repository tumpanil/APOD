import 'package:apod/model/picture_data.dart';
import 'package:apod/repositories/picture_api_client.dart';
import 'package:flutter/material.dart';

class PictureRepository {
  final PictureAPIClient pictureAPIClient;

  const PictureRepository({@required this.pictureAPIClient});

  Future<PictureData> getPictureDetails() {
    return pictureAPIClient.getPictureDetails();
  }
}
