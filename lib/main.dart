import 'package:fetestproject/services/bloc/periode_bloc.dart';
import 'package:fetestproject/services/bloc/rank_bloc.dart';
import 'package:fetestproject/services/bloc/sports_bloc.dart';
import 'package:fetestproject/services/event/periode_event.dart';
import 'package:fetestproject/services/event/rank_event.dart';
import 'package:fetestproject/services/event/sports_event.dart';
import 'package:fetestproject/services/init_binding.dart';
import 'package:flutter/material.dart';
import 'package:fetestproject/router/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  InitBinding().dependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),),
      BlocProvider(create: (_) => PeriodeBloc()..add(FetchPeriodeEvent()),),
      BlocProvider(create: (_) => SportsBloc()..add(FetchSportsEvent()),)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}