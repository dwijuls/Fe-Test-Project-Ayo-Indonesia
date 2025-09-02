import 'package:fetestproject/resources/views/empty/empty.dart';
import 'package:fetestproject/resources/views/home/home.dart';
import 'package:fetestproject/resources/views/leaderboard_one/leaderboard_one.dart';
import 'package:fetestproject/services/bloc/periode_bloc.dart';
import 'package:fetestproject/services/bloc/rank_bloc.dart';
import 'package:fetestproject/services/event/periode_event.dart';
import 'package:fetestproject/services/event/rank_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),)
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/one',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),),
          BlocProvider(create: (_) => PeriodeBloc()..add(FetchPeriodeEvent()),)
        ],
        child: const LeaderBoardOne(),
      ),
    ),
    GoRoute(
      path: '/two',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),)
        ],
        child: const LeaderBoardOne(),
      ),
    ),
    GoRoute(
      path: '/three',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),)
        ],
        child: const LeaderBoardOne(),
      ),
    ),
    GoRoute(
      path: '/four',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RankBloc()..add(FetchRankEvent()),)
        ],
        child: const EmptyPage(),
      ),
    ),
  ],
);