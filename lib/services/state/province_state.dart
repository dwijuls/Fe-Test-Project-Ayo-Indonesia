import 'package:fetestproject/models/province_models.dart';

abstract class ProvinceState {}
class ProvinceInitial extends ProvinceState {}
class ProvinceLoading extends ProvinceState {}
class ProvinceLoaded extends ProvinceState {
  final List<ProvinceModels> provinces;
  final List<ProvinceModels> filteredProvinces;
  final String? selectedProvince;
  final bool isListView;
  ProvinceLoaded(this.provinces, {required this.filteredProvinces, this.selectedProvince, required this.isListView});
}
class ProvinceError extends ProvinceState {
  final String message;
  ProvinceError(this.message);
}