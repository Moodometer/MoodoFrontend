part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final UserModel user;

  HomeStateLoaded({required this.user});
}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError({required this.errorMessage});
}
