import 'package:fetestproject/helpers/constants.dart';
import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/models/rank_models.dart';
import 'package:fetestproject/resources/global/separator.dart';
import 'package:fetestproject/services/bloc/periode_bloc.dart';
import 'package:fetestproject/services/bloc/rank_bloc.dart';
import 'package:fetestproject/services/event/rank_event.dart';
import 'package:fetestproject/services/state/periode_state.dart';
import 'package:fetestproject/services/state/rank_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalBottomsheet extends StatefulWidget {
  const GlobalBottomsheet({super.key});

  @override
  _GlobalBottomsheetState createState() => _GlobalBottomsheetState();
}

class _GlobalBottomsheetState extends State<GlobalBottomsheet> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  showBottomSheetPodiumList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This is crucial for making it full-screen
      builder: (context) {
        // DraggableScrollableSheet allows the bottom sheet to be dragged
        // and provides control over its size.
        return DraggableScrollableSheet(
          // initialChildSize sets the starting height of the bottom sheet.
          initialChildSize: 0.4,
          // minChildSize sets the minimum height of the bottom sheet.
          minChildSize: 0.25,
          // maxChildSize sets the maximum height, allowing it to go full screen.
          maxChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Handle for dragging the sheet
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      // ListView.builder makes the content scrollable
                      child: BlocBuilder<RankBloc, RankState>(
                        builder: (context, state) {
                          if (state is RankInit || state is RankLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is RankLoaded) {
                            return ListView.separated(
                              controller: scrollController,
                              itemCount: state.rankingItems.length-3,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Image.asset(state.rankingItems[index+3].icon, height: 35.0,),
                                      SizedBox(width: 10.0,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.rankingItems[index+3].name, style: TextStyle(fontFamily: 'Rubik', fontSize: 14.0)),
                                            Text(state.rankingItems[index+3].location, style: TextStyle(fontFamily: 'Rubik', fontSize: 12.0, color: Colors.black54)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(state.rankingItems[index+3].flag.toString() == "up" ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                                          Text('${state.rankingItems[index+3].points}Pts', style: TextStyle(fontFamily: 'Rubik', fontSize: 12.0)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  leading: Text('${index+4}', style: TextStyle(fontFamily: 'Rubik', fontSize: 14.0),),
                                );
                              },
                            );
                          }
                          return const Center(child: Text('Failed to load data'));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  showBottomSheetSelectSeason(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This is crucial for making it full-screen
      builder: (context) {
        // DraggableScrollableSheet allows the bottom sheet to be dragged
        // and provides control over its size.
        return DraggableScrollableSheet(
          // initialChildSize sets the starting height of the bottom sheet.
          initialChildSize: 0.4,
          // minChildSize sets the minimum height of the bottom sheet.
          minChildSize: 0.25,
          // maxChildSize sets the maximum height, allowing it to go full screen.
          maxChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // Handle for dragging the sheet

                        const SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                            child: Text(
                              'Periode',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 16.0),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          )
                        ],),
                        const SizedBox(height: 16),
                        Expanded(
                          // ListView.builder makes the content scrollable
                          child: BlocBuilder<PeriodeBloc, PeriodeState>(
                            builder: (context, state) {
                              if (state is PeriodeInit || state is PeriodeLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is PeriodeLoaded) {
                                return ListView.separated(
                                  controller: scrollController,
                                  itemCount: state.periodeItems.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) => const Divider(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          setState(() {

                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.periodeItems[index].name, style: TextStyle(fontFamily: 'Rubik', fontSize: 14.0)),
                                                  state.periodeItems[index].description != '' ? Text(state.periodeItems[index].description, style: TextStyle(fontFamily: 'Rubik', fontSize: 12.0, color: Colors.black54)): SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                            index == 1 ? Icon(Icons.circle_outlined, color: constants.primaryColor, weight: 900,) : Icon(Icons.circle_outlined, color: Colors.black26,)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(child: Text('Failed to load data'));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  showBottomSheetQuestion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This is crucial for making it full-screen
      builder: (context) {
        // DraggableScrollableSheet allows the bottom sheet to be dragged
        // and provides control over its size.
        return DraggableScrollableSheet(
          // initialChildSize sets the starting height of the bottom sheet.
          initialChildSize: 0.8,
          // minChildSize sets the minimum height of the bottom sheet.
          minChildSize: 0.25,
          // maxChildSize sets the maximum height, allowing it to go full screen.
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Handle for dragging the sheet
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cara Mendapatkan Point',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      // ListView.builder makes the content scrollable
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                            child: Text(
                              'Kamu harus menyelesaikan pertandingan untuk dapat mendapatkan point.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w400, fontSize: 12.0, color: Colors.black54),
                            ),),
                            Padding(padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                              child: Text(
                                'Hasil Pertandingan',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.black),
                              ),),
                            Padding(padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                              child:Card(
                                elevation: 0.0,
                                color: Colors.white,
                                margin: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      width: 0.5,
                                        color: Colors.black26,
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Menang',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE3F6F1),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '+100 Pts',
                                              style: TextStyle(
                                                color: Color(0xFF00C48C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                      child: const MySeparator(color: Colors.black26),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Draw',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE3F6F1),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '+50 Pts',
                                              style: TextStyle(
                                                color: Color(0xFF00C48C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                      child: const MySeparator(color: Colors.black26),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Kalah',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFDE3E1),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '-50 Pts',
                                              style: TextStyle(
                                                color: Color(0xFFF44335),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                              child: Text(
                                'Bonus Point',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.black),
                              ),),
                            Padding(padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                              child:Card(
                                elevation: 0.0,
                                color: Colors.white,
                                margin: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      width: 0.5,
                                      color: Colors.black26,
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Bonus Kemenangan',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE3F6F1),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              'n x 5 Pts',
                                              style: TextStyle(
                                                color: Color(0xFF00C48C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),),
                                    Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
                                      child: Text(
                                        'Point (n) didapatkan berdasarkan selisih peringkat dengan lawan di leaderboard. Nilai point maksimum yang dapat ditambahkan adalah 20 Pts',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.black54),
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  showDeveloperInfo(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 0.0,
                              top: 13.0,
                              bottom: 0.0),
                          width: 60.0,
                          height: 3.0,
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Developer Information',
                              style: TextStyle(
                                  fontFamily: 'Toyota',
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Image.asset(
                              DrawableX.imageAsset(AssetGambar.iconsAvaPodium1),
                              width: 70.0,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Krisnadi D.J',
                              style: TextStyle(
                                  fontFamily: 'Toyota',
                                  color: Colors.black,
                                  fontSize: 18.0),
                            ),
                            Text(
                              'Mobile Apps Developer',
                              style: TextStyle(
                                  fontFamily: 'Toyota',
                                  color: Colors.black45,
                                  fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                                'My Portfolio',
                                style: TextStyle(
                                    fontFamily: 'Toyota',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: (){
                                _launchUrl();
                              },
                              child: Text(
                                  'https://dwijuls.github.io/cv',
                                  style: TextStyle(
                                      fontFamily: 'Toyota',
                                      color: constants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('https://dwijuls.github.io/cv'))) {
      throw Exception('Could not launch https://dwijuls.github.io/cv');
    }
  }
}