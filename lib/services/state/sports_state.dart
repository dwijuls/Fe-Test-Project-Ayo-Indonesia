import 'package:fetestproject/models/sports_models.dart';

abstract class SportsState {}

class SportsInit extends SportsState {}

class SportsLoading extends SportsState {}

class SportsLoaded extends SportsState {
  final List<SportsModels> sportsItems;

  SportsLoaded(this.sportsItems);
}

class SportsError extends SportsState {
  final String message;
  SportsError(this.message);
}