class Movie_image{
  // String title;
  // String id;
  String poster;
  // String fanart;

  Movie_image({
    // required this.title,
    // required this.id,
    required this.poster,
    // required this.fanart,
  });

  factory Movie_image.fromJson(Map<String, dynamic> json){
    return Movie_image(
      // title : json["title"],
      // id: json["IMDB"],
      poster: json["poster"] ?? 'https://movies-tv-shows-database.p.rapidapi.com/?movieid=tt11097384',
      // fanart: json["fanart"],
    );
  }

}




// title:"Inception"
// IMDB:"tt1375666"
// poster:"http://image.tmdb.org/t/p/original/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg"
// fanart:"http://image.tmdb.org/t/p/original/s3TBrRGB1iav7gFOCNx3H31MoES.jpg"
// status:"OK"
// status_message:"Query was successful"