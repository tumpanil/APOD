import 'package:apod/model/picture_data.dart';
import 'package:apod/repositories/picture_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final PictureRepository pictureRepository;

  PictureBloc({@required this.pictureRepository})
      : assert(pictureRepository != null),
        super(InitialState());

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
    if (event is FetchPictureDetailsEvent) {
      try {
        final PictureData pictureData =
            await pictureRepository.getPictureDetails();
        yield DetailsFetchedState(pictureData: pictureData);
      } catch (error) {
        yield ErrorState(error: error.toString());
      }
    }
  }
}
