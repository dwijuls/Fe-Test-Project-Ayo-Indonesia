import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/models/periode_models.dart';
import 'package:fetestproject/models/rank_models.dart';
import 'package:fetestproject/services/event/periode_event.dart';
import 'package:fetestproject/services/event/rank_event.dart';
import 'package:fetestproject/services/state/periode_state.dart';
import 'package:fetestproject/services/state/rank_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PeriodeBloc extends Bloc<PeriodeEvent, PeriodeState> {
  PeriodeBloc() : super(PeriodeInit()) {
    on<FetchPeriodeEvent>((event, emit) async {
      emit(PeriodeLoading());
      await Future.delayed(Duration(seconds: 1)); // Simulasi penundaan pengambilan data

      final dummyData = [
        {
          "id": 1,
          "name": "All Time",
          "description": "",
        },
        {
          "id": 2,
          "name": "Januari - Maret 2024",
          "description": "Current Season",
        },
        {
          "id": 3,
          "name": "Oktober - Desember 2023",
          "description": "",
        },
        {
          "id": 4,
          "name": "Juli - Agustus 2023",
          "description": "",
        },
        // Tambahkan data dummy lainnya di sini
      ];

      final periodeItems = dummyData.map((data) {
        return PeriodeModels.fromJson(data);
      }).toList();

      emit(PeriodeLoaded(periodeItems));
    });
  }
}