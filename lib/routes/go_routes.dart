import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/pages/homepage.dart';
import 'package:movie_app/pages/movie_detail.dart';
import 'package:movie_app/pages/splash.dart';


class MyAppRoutes{

  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: Splash());
        }
      ),
      GoRoute(
        name:'homepage',
        path: '/homepage',
        pageBuilder: (context, state){
          return MaterialPage(child: Homepage());
        },
      ),
       GoRoute(
        name:'movie-detail',
        path: '/movie-detail',
        pageBuilder: (context, state){
          return MaterialPage(child: Movie_detail());
        },
    ), 
    ],
  );
}
