import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/models/movie_image.dart';
import 'package:movie_app/pages/movie_detail.dart';

final idStateProvider = StateProvider<String>((ref) {
  return '';
});


// final moviedetailprovider=P
final moviedetailapi= FutureProvider<Movie_data>((ref) async{
  return Api().getmoviedetail(ref.watch(idStateProvider));});

final moviefanartapi = FutureProvider<String>((ref) async{
  return Api().getfanart(ref.watch(idStateProvider));});