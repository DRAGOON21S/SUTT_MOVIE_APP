import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/logic/str_double.dart';
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/widgets/Splash_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Movie_detail extends StatefulWidget {
  final String id;

  Movie_detail({required this.id});

  @override
  State<Movie_detail> createState() => _Movie_detailState();
}

class _Movie_detailState extends State<Movie_detail> {
  

  late Future<Movie_data> getdetail;
  late Future<String> getfanart;
  @override
  void initState(){
    getdetail=Api().getmoviedetail(widget.id);
    getfanart=Api().getfanart(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('movie_details'),
          leading : IconButton(onPressed: ()=>context.pop(), icon: Icon(Icons.arrow_back))
          
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: getdetail,
              builder:(context, snapshot3) {
                if (snapshot3.connectionState == ConnectionState.done && snapshot3.hasData) {
                  return Container(
                    child:Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,1,10,1),
                        child:
                        Text(snapshot3.data!.title, style: TextStyle(fontSize: 30),),),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: FutureBuilder(
                          future: getfanart,
                          builder: (context, snapshot4) {
                            if (snapshot4.connectionState == ConnectionState.done && snapshot4.hasData) {
                              return Image.network(
                              snapshot4.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/404_not_found.png', fit: BoxFit.cover);}
                              );
                          }
                           else {
                              return Splash_widget();
                          }},
                        ),
                      ),
                      ExpansionTile(
                        title: Text('Description'),
                        trailing: Icon(Icons.arrow_drop_down),
                      
                        
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              snapshot3.data!.description,
                              // 'hello',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),],),
                        
                        // Padding(
                        //   padding: EdgeInsets.all(1.0),
                        //   child: Text(
                        //     'Rating: ${snapshot3.data!.rating}',
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        
                        RatingBar.builder(
                          initialRating: StringConverter().Str_double(snapshot3.data!.rating),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: ( double rating) {
                          },
                        ),
          
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Release year : ${snapshot3.data!.year}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Tagline : ${snapshot3.data!.tagline}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Age-Rated : ${snapshot3.data!.rated}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        
                        MaterialButton(
                          onPressed: ()async {
                            final url = Uri.parse('https://www.youtube.com/watch?v=${snapshot3.data!.trailer}');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          color: Colors.red[900],
                          child: Text('Open Trailer'),
                        ),
                        
                        LikeButton(
                          size: 30,
                          circleColor:
                          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                            ),
                          likeBuilder: (bool isLiked) {
                           return Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red[800] : Colors.grey,
                            size: 30,
              );
            },
          
                        ),
                        ],),
                        
          
          
                    
                    );}
                      
                  
                  else {
                  return Center(
                      child: Column(
                        children: [
                          Center(
                            child:
                              CircularProgressIndicator(),),
                              MaterialButton(
                                onPressed:()async{ GoRouter.of(context).go('/homepage');
                                },
                                child: Text('Go back to home page'),
                              ),
                            ],
                          ),
                        );}
                
          
                    }),
        ),
              
            
          );}}
          