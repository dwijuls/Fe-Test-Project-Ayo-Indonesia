abstract class ProvinceEvent {}
class FetchProvincesEvent extends ProvinceEvent {}
class SearchProvinces extends ProvinceEvent {
  final String query;
  SearchProvinces(this.query);
}
class ToggleViewMode extends ProvinceEvent {}
class SelectProvince extends ProvinceEvent {
  final String nama;
  SelectProvince(this.nama);
}