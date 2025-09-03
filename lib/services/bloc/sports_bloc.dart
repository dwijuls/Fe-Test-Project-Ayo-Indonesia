import 'package:fetestproject/models/sports_models.dart';
import 'package:fetestproject/services/event/sports_event.dart';
import 'package:fetestproject/services/state/sports_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsBloc extends Bloc<SportsEvent, SportsState> {
  SportsBloc() : super(SportsInit()) {
    on<FetchSportsEvent>((event, emit) async {
      emit(SportsLoading());
      await Future.delayed(Duration(seconds: 1)); // Simulasi penundaan pengambilan data

      final dummyData = [
        {
          "id": 1,
          "name": "Badminton",
          "icon": Icons.sports_tennis,
          "type": 1,
        },
        {
          "id": 2,
          "name": "Squash",
          "icon": Icons.sports_basketball_outlined,
          "type": 1,
        },
        {
          "id": 3,
          "name": "Padel",
          "icon": Icons.sports_tennis,
          "type": 1,
        },
        {
          "id": 4,
          "name": "Mini Soccer",
          "icon": Icons.sports_soccer,
          "type": 1,
        },
        {
          "id": 5,
          "name": "Tenis Meja",
          "icon": Icons.sports_baseball_rounded,
          "type": 2,
        },
        {
          "id": 6,
          "name": "Tenis",
          "icon": Icons.sports_tennis,
          "type": 2,
        },
        {
          "id": 7,
          "name": "Pickleball",
          "icon": Icons.sports_baseball_outlined,
          "type": 2,
        },
        // Tambahkan data dummy lainnya di sini
      ];

      final sportsItems = dummyData.map((data) {
        return SportsModels.fromJson(data);
      }).toList();

      emit(SportsLoaded(sportsItems));
    });
  }
}