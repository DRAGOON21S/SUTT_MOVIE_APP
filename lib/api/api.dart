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
      'X-Rapidapi-Key': 'd6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    
    
    final headers2 = {
      'Type' : 'get-movies-images-by-imdb',
      'X-Rapidapi-Key': 'd6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    final response = await client.get(url, headers: headers);
    List<Movie_image>movienowimage = [];
    if (response.statusCode == 200){
      final movienowlist = json.decode(response.body)['movie_results'] as List;
      final movienow = movienowlist.map((movie_now)=> Movie_now.fromJson(movie_now)).toList();
      for(int i =0;i<movienow.length;i++){
        final url2 =Uri.parse('https://movies-tv-shows-database.p.rapidapi.com?movieid=${movienow[i].id}');
        client.get(url2);
        final response2 = await client.get(url2, headers: headers2);
        if (response2.statusCode == 200){
          final movieimagelist = json.decode(response2.body);
          final movieimagelist2 = Movie_image.fromJson(movieimagelist);
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
   }

  Future<String> getmovieimage(dynamic id) async{
    final dio = Dio();
    final headers = {
      'Type' : 'get-movies-images-by-imdb',
      "X-Rapidapi-Key": "d6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95",
      'X-Rapidapi-Host': "movies-tv-shows-database.p.rapidapi.com",
    };
    try {
      final response = await dio.get('https://movies-tv-shows-database.p.rapidapi.com?movieid=$id' , options: Options(headers: headers));
      if (response.statusCode == 200){
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
     "X-Rapidapi-Key": "d6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95",
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
      'X-Rapidapi-Key': 'd6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    var dio = Dio();
    try {
      final response1 = await dio.get('https://movies-tv-shows-database.p.rapidapi.com?movieid=$id' , options: Options(headers: headers));
      // print(response1.data);
      final responseData = response1.data;
      final model = Movie_data.fromJson(responseData);
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

Future<List<Movie_image>> getmovieresult(String name) async{
  final headers = {
      'Type' : 'get-movies-by-title',
      'X-Rapidapi-Key': 'd6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
  final headers2 = {
      'Type' : 'get-movies-images-by-imdb',
      'X-Rapidapi-Key': 'd6928efbf1mshb22eb73bf3c30d7p11c905jsneb48f8278b95',
      'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
    };
    final url =Uri.parse("https://movies-tv-shows-database.p.rapidapi.com/?title=${name}");
    client.get(url);
    List<Movie_image>searchresultimage = [];
    
    final response2 = await client.get(url, headers: headers);
      if (response2.statusCode == 200){
        final qwerty = json.decode(response2.body)['search_results'];
        if(qwerty>0){
          final searchresultlist = json.decode(response2.body)['movie_results'] as List;
          final searchresult = searchresultlist.map((search_result)=> Movie_now.fromJson(search_result)).toList();
          for(int i =0;i<searchresult.length;i++){
            final url2=Uri.parse('https://movies-tv-shows-database.p.rapidapi.com?movieid=${searchresult[i].id}');
            final response3 = await client.get(url2, headers: headers2);
            if (response3.statusCode == 200){
              final searchimagelist = json.decode(response3.body);
              // print(searchimagelist);
              final searchimagelist2 = Movie_image.fromJson(searchimagelist);
              searchresultimage.add(searchimagelist2);

        }
          else{
            print(response2.statusCode);
            throw Exception("newnewcodefailed");
        
        }}
         return searchresultimage;}
         else{
          searchresultimage.add(Movie_image(title: '', id: '', poster: ''));
          return searchresultimage;
         }
         }
      else {
        print("error");
        throw Exception('error');
      }
    }
    }
  
   