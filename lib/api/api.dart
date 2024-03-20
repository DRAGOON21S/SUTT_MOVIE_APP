import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/models/movie_image.dart';
import 'package:movie_app/models/movie_now_playing.dart';
import 'package:dio/dio.dart';

var client = http.Client();

class Api{
  Future<List<Movie_image>> getnowplaying() async {
  final url = Uri.parse("https://movies-tv-shows-database.p.rapidapi.com?page=1");
  final headers = {
    'Type': 'get-nowplaying-movies',
    'X-Rapidapi-Key': '8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f',
    'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
  };

  final headers2 = {
    'Type': 'get-movies-images-by-imdb',
    'X-Rapidapi-Key': '8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f',
    'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com'
  };

  final response = await client.get(url, headers: headers);
  List<Movie_image> movienowimage = [];

  if (response.statusCode == 200) {
    final movienowlist = json.decode(response.body)['movie_results'] as List;
    final movienow = movienowlist.map((movie_now) => Movie_now.fromJson(movie_now)).toList();

    List<Future<Movie_image>> movieImageFutures = [];
    for (int i = 0; i < movienow.length; i++) {
      final url2 = Uri.parse('https://movies-tv-shows-database.p.rapidapi.com?movieid=${movienow[i].id}');
      movieImageFutures.add(client.get(url2, headers: headers2).then((response2) {
        if (response2.statusCode == 200) {
          final movieimagelist = json.decode(response2.body);
          return Movie_image.fromJson(movieimagelist);
        } else {
          print(response2.statusCode);
          throw Exception("newcodefailed");
        }
      }));
    }

    final movieImagesList = await Future.wait(movieImageFutures);

    movienowimage.addAll(movieImagesList);

    return movienowimage;
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

  Future<String> getmovieimage(dynamic id) async{
    final dio = Dio();
    final headers = {
      'Type' : 'get-movies-images-by-imdb',
      "X-Rapidapi-Key": "8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f",
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
     "X-Rapidapi-Key": "8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f",
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
      'X-Rapidapi-Key': '8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f',
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

Future<List<Movie_image>> getmovieresult(String name) async {
  final headers = {
    'Type': 'get-movies-by-title',
    'X-Rapidapi-Key': '8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f',
    'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };
  final headers2 = {
    'Type': 'get-movies-images-by-imdb',
    'X-Rapidapi-Key': '8c1674b0d6msh145daffaa29913cp1d4d8fjsn2789aa40069f',
    'X-Rapidapi-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };
  final url = Uri.parse("https://movies-tv-shows-database.p.rapidapi.com/?title=${name}");
  client.get(url);
  List<Movie_image> searchResultImages = [];

  final response2 = await client.get(url, headers: headers);
  if (response2.statusCode == 200) {
    final qwerty = json.decode(response2.body)['search_results'];
    if (qwerty > 0) {
      final searchResultList = json.decode(response2.body)['movie_results'] as List;
      final searchResult = searchResultList.map((search_result) => Movie_now.fromJson(search_result)).toList();

      final futures = <Future<Movie_image>>[];
      for (int i = 0; i < searchResult.length; i++) {
        final url2 = Uri.parse('https://movies-tv-shows-database.p.rapidapi.com?movieid=${searchResult[i].id}');
        final future = client.get(url2, headers: headers2).then((response3) async {
          if (response3.statusCode == 200) {
            final searchImageList = json.decode(response3.body);
            return Movie_image.fromJson(searchImageList);
          } else {
            throw Exception("newnewcodefailed");
          }
        });
        futures.add(future);
      }

      final images = await Future.wait(futures);
      searchResultImages.addAll(images);

      return searchResultImages;
    } else {
      searchResultImages.add(Movie_image(title: '', id: '', poster: ''));
      return searchResultImages;
    }
  } else {
    print("error");
    throw Exception('error');
  }
}
    }
  
   