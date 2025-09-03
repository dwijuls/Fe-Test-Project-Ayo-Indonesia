import 'dart:convert';
import 'dart:io';

import 'package:fetestproject/models/province_models.dart';
import 'package:fetestproject/services/event/province_event.dart';
import 'package:fetestproject/services/state/province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// Fallback data in case API fails
const List<Map<String, dynamic>> fallbackProvinces = [
  {"id": "11", "nama": "ACEH"},
  {"id": "12", "nama": "SUMATERA UTARA"},
  {"id": "13", "nama": "SUMATERA BARAT"},
  {"id": "31", "nama": "DKI JAKARTA"},
  {"id": "32", "nama": "JAWA BARAT"},
];
class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial()) {
    on<FetchProvincesEvent>(_onFetchProvinces);
    on<SearchProvinces>(_onSearchProvinces);
    on<ToggleViewMode>(_onToggleViewMode);
    on<SelectProvince>(_onSelectProvince);
  }

  Future<void> _onFetchProvinces(FetchProvincesEvent event, Emitter<ProvinceState> emit) async {
    emit(ProvinceLoading());
    print('Fetching provinces from API...');
    try {
      final response = await http.get(Uri.parse('https://ibnux.github.io/data-indonesia/provinsi.json')).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('API request timed out');
          throw const SocketException('Connection timed out');
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> provinceData = jsonData;
        final provinces = provinceData.map((json) => ProvinceModels.fromJson(json)).toList();
        print('API fetch successful, ${provinces.length} provinces loaded');
        emit(ProvinceLoaded(provinces, filteredProvinces: provinces, selectedProvince: provinces.isNotEmpty ? provinces[0].nama : null, isListView: false));
      } else {
        print('API returned status: ${response.statusCode}');
        emit(ProvinceError('Failed to load provinces: ${response.statusCode}'));
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      // Fallback to local data
      final fallback = fallbackProvinces.map((json) => ProvinceModels.fromJson(json)).toList();
      print('Falling back to local data, ${fallback.length} provinces loaded');
      emit(ProvinceLoaded(fallback, filteredProvinces: fallback, selectedProvince: fallback.isNotEmpty ? fallback[0].nama : null, isListView: false));
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProvinceError('Unexpected error: $e'));
    }
  }

  void _onSearchProvinces(SearchProvinces event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      final allProvinces = currentState.provinces;
      final filteredProvinces = event.query.isEmpty
          ? allProvinces
          : allProvinces.where((province) => province.nama!.toLowerCase().contains(event.query.toLowerCase())).toList();
      print('Search query: ${event.query}, ${filteredProvinces.length} results');
      emit(ProvinceLoaded(allProvinces, filteredProvinces: filteredProvinces, selectedProvince: currentState.selectedProvince, isListView: event.query.isEmpty ? false : true));
    }
  }

  void _onToggleViewMode(ToggleViewMode event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      print('Toggling view mode to ${!currentState.isListView}');
      emit(ProvinceLoaded(currentState.provinces, filteredProvinces: currentState.filteredProvinces, selectedProvince: currentState.selectedProvince, isListView: !currentState.isListView));
    }
  }

  void _onSelectProvince(SelectProvince event, Emitter<ProvinceState> emit) {
    if (state is ProvinceLoaded) {
      final currentState = state as ProvinceLoaded;
      print('Selected province: ${event.nama}');
      emit(ProvinceLoaded(currentState.provinces, filteredProvinces: currentState.filteredProvinces, selectedProvince: event.nama, isListView: false));
    }
  }
}