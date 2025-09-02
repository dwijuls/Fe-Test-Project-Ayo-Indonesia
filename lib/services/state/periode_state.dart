import 'package:fetestproject/models/periode_models.dart';

abstract class PeriodeState {}

class PeriodeInit extends PeriodeState {}

class PeriodeLoading extends PeriodeState {}

class PeriodeLoaded extends PeriodeState {
  final List<PeriodeModels> periodeItems;

  PeriodeLoaded(this.periodeItems);
}