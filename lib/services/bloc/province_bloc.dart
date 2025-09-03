import 'dart:convert';

import 'package:fetestproject/models/province_models.dart';
import 'package:fetestproject/services/event/province_event.dart';
import 'package:fetestproject/services/state/province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial()) {
    on<FetchProvincesEvent>(_onFetchProvinces);
    on<SearchProvinces>(_onSearchProvinces);
    on<ToggleViewMode>(_onToggleViewMode);
    on<SelectProvince>(_onSelectProvince);
  }

  Future<void> _onFetchProvinces(FetchProvincesEvent event, Emitter<ProvinceState> emit) async {
    emit(ProvinceLoading());
    try {
      final response = await http.get(Uri.parse('https://ibnux.github.io/data-indonesia/provinsi.json'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> provinceData = jsonData;
        final provinces = provinceData.map((json) => ProvinceModels.fromJson(json)).toList();
        emit(ProvinceLoaded(provinces, selectedProvince: provinces.isNotEmpty ? provinces[0].nama : null, isListView: false));
      } else {
        emit(ProvinceError('Failed to load provinces: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProvinceError('Error fetching provinces: $e'));
    }
  }

  void _onSearchProvinces(SearchProvinces event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      final allProvinces = currentState.provinces;
      final filteredProvinces = allProvinces
          .where((province) => province.nama!.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProvinceLoaded(allProvinces, selectedProvince: currentState.selectedProvince, isListView: true));
    }
  }

  void _onToggleViewMode(ToggleViewMode event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      emit(ProvinceLoaded(currentState.provinces, selectedProvince: currentState.selectedProvince, isListView: !currentState.isListView));
    }
  }

  void _onSelectProvince(SelectProvince event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      emit(ProvinceLoaded(currentState.provinces, selectedProvince: event.nama, isListView: false));
    }
  }
}