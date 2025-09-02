import 'package:fetestproject/models/rank_models.dart';

abstract class RankState {}

class RankInit extends RankState {}

class RankLoading extends RankState {}

class RankLoaded extends RankState {
  final List<RankModels> rankingItems;

  RankLoaded(this.rankingItems);
}