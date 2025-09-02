import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/models/rank_models.dart';
import 'package:fetestproject/services/event/rank_event.dart';
import 'package:fetestproject/services/state/rank_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RankBloc extends Bloc<RankEvent, RankState> {
  RankBloc() : super(RankInit()) {
    on<FetchRankEvent>((event, emit) async {
      emit(RankLoading());
      await Future.delayed(Duration(seconds: 1)); // Simulasi penundaan pengambilan data

      final dummyData = [
        {
          "id": 1,
          "name": "Purple",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAvaPodium1),
          "location": "Surabaya",
          "points": 450,
          "flag": "up"
        },
        {
          "id": 2,
          "name": "Teal",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAvaPodium2),
          "location": "Surabaya",
          "points": 370,
          "flag": "up"
        },
        {
          "id": 3,
          "name": "Pinky",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAvaPodium3),
          "location": "Surabaya",
          "points": 290,
          "flag": "up"
        },
        {
          "id": 4,
          "name": "Bleu House",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAva_1),
          "location": "Surabaya",
          "points": 105,
          "flag": "up"
        },
        {
          "id": 5,
          "name": "UFO Enthusiast",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAvaPodium1),
          "location": "Surabaya",
          "points": 100,
          "flag": "up"
        },
        {
          "id": 6,
          "name": "Grizzly Community",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAva_2),
          "location": "Surabaya",
          "points": 96,
          "flag": "down"
        },
        {
          "id": 7,
          "name": "Komunitas Kawan AYO",
          "icon": DrawableX.imageAsset(AssetGambar.iconsAva_3),
          "location": "Surabaya",
          "points": 90,
          "flag": "up"
        },
        // Tambahkan data dummy lainnya di sini
      ];

      final rankingItems = dummyData.map((data) {
        return RankModels.fromJson(data);
      }).toList();

      emit(RankLoaded(rankingItems));
    });
  }
}