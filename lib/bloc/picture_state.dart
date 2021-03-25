part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object> get props => [];
}

class InitialState extends PictureState {}

class DetailsFetchedState extends PictureState {
  final PictureData pictureData;

  const DetailsFetchedState({@required this.pictureData});

  @override
  List<Object> get props => [pictureData];
}

class ErrorState extends PictureState {
  final String error;

  const ErrorState({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];
}
