import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/models/movie_image.dart';
import 'package:movie_app/models/movie_now_playing.dart';
import 'package:dio/dio.dart';

var client = http.Client();

class Api{
  Future<List<Movie_image>> getnowplaying() async{
    final url =Uri.parse("https://movies-tv-shows-database.p.rapidapi.com?page=1");
    client.get(url);
    final headers = {
      'Type' : 'get-nowplaying-movies',
      'X-Rapidapi-Key': '91a5595eabmsha74e46be37f3932p142907jsne3576302a468',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    
    
    final headers2 = {
      'Type' : 'get-movies-images-by-imdb',
      'X-Rapidapi-Key': '91a5595eabmsha74e46be37f3932p142907jsne3576302a468',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    final response = await client.get(url, headers: headers);
    List<Movie_image>movienowimage = [];
    if (response.statusCode == 200){
      final movienowlist = json.decode(response.body)['movie_results'] as List;
      // print(response.isRedirect);
      final movienow = movienowlist.map((movie_now)=> Movie_now.fromJson(movie_now)).toList();
      for(int i =0;i<movienow.length;i++){
        final url2 =Uri.parse('https://movies-tv-shows-database.p.rapidapi.com?movieid=${movienow[i].id}');
        // print(movienow[i].id);
        client.get(url2);
        final response2 = await client.get(url2, headers: headers2);
        if (response2.statusCode == 200){
          // print('step${i}');
          final movieimagelist = json.decode(response2.body);
          print(movieimagelist);
          final movieimagelist2 = Movie_image.fromJson(movieimagelist);
          print(movieimagelist2.poster);
          movienowimage.add(movieimagelist2);

        }
        else{
          print(response2.statusCode);
          throw Exception("newcodefailed");
        } 
      }
      return movienowimage;
    }
    else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
    
    
    
    //   return movieimagelist.map((movie_image)=> Movie_image.fromJson(movie_image)).toList();
    // }
    // else {
    //   print(response2.statusCode);
    //   throw Exception(response2.statusCode);
    // }

  }

  Future<String> getmovieimage(dynamic id) async{
    final dio = Dio();
    final headers = {
      'Type' : 'get-movies-images-by-imdb',
      "X-Rapidapi-Key": "91a5595eabmsha74e46be37f3932p142907jsne3576302a468",
      'X-Rapidapi-Host': "movies-tv-shows-database.p.rapidapi.com",
    };
    try {
    final response = await dio.get('https://movies-tv-shows-database.p.rapidapi.com?movieid=$id' , options: Options(headers: headers));
    // print(response.data["poster"].toString());
    if (response.statusCode == 200){
      // final movieimagelist = json.decode(response.body) as List ;
      // return movieimagelist.map((movie_image)=> Movie_image.fromJson(movie_image)).toList();
      // print(response.data['fanart']);
      // print(response.data['title']);
      // print(response.isRedirect);
      // print(response.redirects);
      // print(response.realUri.toString());
      return response.data["poster"].toString();
    }
    else {
      print("error");
      throw Exception('error');
    }

  }
  on DioException catch (e) {
    print(e.message);
    throw Exception(e.message);
  }
  }
  
  
  
  Future<String> getfanart(dynamic id) async{
    final dio = Dio();
    final headers = {
      'Type' : 'get-movies-images-by-imdb',
     "X-Rapidapi-Key": "91a5595eabmsha74e46be37f3932p142907jsne3576302a468",
      'X-Rapidapi-Host': "movies-tv-shows-database.p.rapidapi.com",
    };
    try {
    final response = await dio.get('https://movies-tv-shows-database.p.rapidapi.com?movieid=$id' , options: Options(headers: headers));
    if (response.statusCode == 200){
      return response.data["fanart"].toString();
    }
    else {
      print("error");
      throw Exception('error');
    }

  }
  on DioException catch (e) {
    print(e.message);
    throw Exception(e.message);
  }
  }

  Future<Movie_data> getmoviedetail(String id) async {
    final headers = {
      'Type' : 'get-movie-details',
      'X-Rapidapi-Key': '91a5595eabmsha74e46be37f3932p142907jsne3576302a468',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    var dio = Dio();
    try {
    final response1 = await dio.get('https://movies-tv-shows-database.p.rapidapi.com?movieid=$id' , options: Options(headers: headers));
    // print(response1.data);
    final responseData = response1.data;
    final model = Movie_data.fromJson(responseData as Map<String, dynamic>);
    if (response1.statusCode == 200){
      return model;
    }
    else {
      print("error");
      throw Exception('error');
    }
  }
  on DioException catch (e) {
    print(e.message);
    throw Exception(e.message);
  }
  }

  }