import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/pages/homepage.dart';
import 'package:movie_app/pages/movie_detail.dart';
import 'package:movie_app/pages/search_result.dart';
import 'package:movie_app/pages/sign_in.dart';
import 'package:movie_app/pages/splash.dart';


class MyAppRoutes{
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Splash());
        }
      ),
      GoRoute(
        name:'homepage',
        path: '/homepage',
        pageBuilder: (context, state){
          return const MaterialPage(child: Homepage());
        },
      ),
      GoRoute(
      name:'movie-detail',
      path: '/movie-detail/:id',
      pageBuilder: (context, state){
        return MaterialPage(child: Movie_detail(id:state.pathParameters['id']!));
      },
      ), 
      GoRoute(
        name: 'sign-in',
        path: '/signin',
        pageBuilder: (context, state){
          return const MaterialPage(child: SignIn_google());},
      ),
      GoRoute(
        name:'search-result',
        path:'/search-result/:name',
        pageBuilder: (context,state){
          return MaterialPage(child: Search_result(name:state.pathParameters['name']!));
        }
      ),
      GoRoute(
        name:'searchbox',
        path:'/searchbox',
        pageBuilder:(context,state){
          return const MaterialPage(child: SearchBox());
        }

      )
    ],
  );
}
