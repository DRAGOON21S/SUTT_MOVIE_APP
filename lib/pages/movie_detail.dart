import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/logic/str_double.dart';
import 'package:movie_app/models/movie_data.dart';
import 'package:movie_app/pages/provider.dart';
import 'package:movie_app/widgets/Splash_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Movie_detail extends ConsumerWidget{
   Movie_detail({Key? key}) : super(key: key);

  late Future<Movie_data> getdetail;
  late Future<String> getfanart;
  // @override
  // void initState(){
  //   final hi = ref.read(idStateProvider);
  //   getdetail=Api().getmoviedetail(hi);
  //   getfanart=Api().getfanart(hi);
    
  //   print(hi);
  // }

  @override
  Widget build(BuildContext context, ref) {
    final _data = ref.watch(moviedetailapi);
    final _fanart = ref.watch(moviefanartapi);
    return Scaffold(
        appBar: AppBar(
          title: Text('movie_details'),
          leading : IconButton(icon: Icon(Icons.arrow_back), onPressed: (){context.pop();
          ref.read(idStateProvider.notifier).state='';})
          
        ),
        body: _data.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (_data) {
            final hi = _data;
            return Container(
                    child:Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,1,10,1),
                        child:
                        Text(hi.title, style: TextStyle(fontSize: 30),),),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _fanart.when(
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Text('Error: $err'),
                          data: (_fanart) {
                            return Image.network(
                              _fanart,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/404_not_found.png', fit: BoxFit.cover);},
                            );
                          },
                        )
                        // child: FutureBuilder(
                        //   future: getfanart,
                        //   builder: (context, snapshot4) {
                        //     if (snapshot4.connectionState == ConnectionState.done && snapshot4.hasData) {
                        //       return Image.network(
                        //       snapshot4.data!,
                        //       fit: BoxFit.cover,
                        //       errorBuilder: (context, error, stackTrace) {
                        //           return Image.asset('assets/images/404_not_found.png', fit: BoxFit.cover);}
                        //       );
                        //   }
                        //    else {
                        //       return Splash_widget();
                        //   }},
                        // ),
                      ),
                      ExpansionTile(
                        title: Text('Description'),
                        trailing: Icon(Icons.arrow_drop_down),
                      
                        
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              hi.description,
                              // 'hello',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),],),
                        
                        // Padding(
                        //   padding: EdgeInsets.all(1.0),
                        //   child: Text(
                        //     'Rating: ${hi.rating}',
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        
                        RatingBar.builder(
                          initialRating: StringConverter().Str_double(hi.rating),
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
                            'Release year : ${hi.year}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Tagline : ${hi.tagline}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            'Age-Rated : ${hi.rated}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        
                        MaterialButton(
                          onPressed: ()async {
                            final url = Uri.parse('https://www.youtube.com/watch?v=${hi.trailer}');
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
          // }
          )
        // body: SingleChildScrollView(
        //   child: FutureBuilder(
        //       future: getdetail,
        //       builder:(context, snapshot3) {
        //         if (snapshot3.connectionState == ConnectionState.done && snapshot3.hasData) {
        //           return Container(
        //             child:Column(
        //             // crossAxisAlignment: CrossAxisAlignment.stretch,
        //             children: [
        //               Padding(
        //                 padding: EdgeInsets.fromLTRB(10,1,10,1),
        //                 child:
        //                 Text(hi.title, style: TextStyle(fontSize: 30),),),
        //               AspectRatio(
        //                 aspectRatio: 16 / 9,
        //                 child: FutureBuilder(
        //                   future: getfanart,
        //                   builder: (context, snapshot4) {
        //                     if (snapshot4.connectionState == ConnectionState.done && snapshot4.hasData) {
        //                       return Image.network(
        //                       snapshot4.data!,
        //                       fit: BoxFit.cover,
        //                       errorBuilder: (context, error, stackTrace) {
        //                           return Image.asset('assets/images/404_not_found.png', fit: BoxFit.cover);}
        //                       );
        //                   }
        //                    else {
        //                       return Splash_widget();
        //                   }},
        //                 ),
        //               ),
        //               ExpansionTile(
        //                 title: Text('Description'),
        //                 trailing: Icon(Icons.arrow_drop_down),
                      
                        
        //                 children: [
        //                   Padding(
        //                     padding: EdgeInsets.all(1.0),
        //                     child: Text(
        //                       hi.description,
        //                       // 'hello',
        //                       style: TextStyle(fontSize: 20),
        //                     ),
        //                   ),],),
                        
        //                 // Padding(
        //                 //   padding: EdgeInsets.all(1.0),
        //                 //   child: Text(
        //                 //     'Rating: ${hi.rating}',
        //                 //     style: TextStyle(fontSize: 20),
        //                 //   ),
        //                 // ),
                        
        //                 RatingBar.builder(
        //                   initialRating: StringConverter().Str_double(hi.rating),
        //                   minRating: 0,
        //                   direction: Axis.horizontal,
        //                   allowHalfRating: true,
        //                   itemCount: 5,
        //                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        //                   itemBuilder: (context, _) => Icon(
        //                     Icons.star,
        //                     color: Colors.amber,
        //                   ),
        //                   onRatingUpdate: ( double rating) {
        //                   },
        //                 ),
          
        //                 Padding(
        //                   padding: EdgeInsets.all(1.0),
        //                   child: Text(
        //                     'Release year : ${hi.year}',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.all(1.0),
        //                   child: Text(
        //                     'Tagline : ${hi.tagline}',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.all(1.0),
        //                   child: Text(
        //                     'Age-Rated : ${hi.rated}',
        //                     style: TextStyle(fontSize: 20),
        //                   ),
        //                 ),
                        
        //                 MaterialButton(
        //                   onPressed: ()async {
        //                     final url = Uri.parse('https://www.youtube.com/watch?v=${hi.trailer}');
        //                     if (await canLaunchUrl(url)) {
        //                       await launchUrl(url);
        //                     } else {
        //                       throw 'Could not launch $url';
        //                     }
        //                   },
        //                   color: Colors.red[900],
        //                   child: Text('Open Trailer'),
        //                 ),
                        
        //                 LikeButton(
        //                   size: 30,
        //                   circleColor:
        //                   CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        //                   bubblesColor: BubblesColor(
        //                   dotPrimaryColor: Color(0xff33b5e5),
        //                   dotSecondaryColor: Color(0xff0099cc),
        //                     ),
        //                   likeBuilder: (bool isLiked) {
        //                    return Icon(
        //                     Icons.favorite,
        //                     color: isLiked ? Colors.red[800] : Colors.grey,
        //                     size: 30,
        //       );
        //     },
          
        //                 ),
        //                 ],),
                        
          
          
                    
        //             );}
                      
                  
        //           else {
        //           return Center(
        //               child: Column(
        //                 children: [
        //                   Center(
        //                     child:
        //                       CircularProgressIndicator(),),
        //                       MaterialButton(
        //                         onPressed:()async{ GoRouter.of(context).go('/homepage');
        //                         },
        //                         child: Text('Go back to home page'),
        //                       ),
        //                     ],
        //                   ),
        //                 );}
                
          
        //             }),
        // ),
              
            
          );}}
          