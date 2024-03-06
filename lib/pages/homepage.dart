import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/models/movie_image.dart';
import 'package:movie_app/models/movie_now_playing.dart';
import 'package:movie_app/pages/movie_detail.dart';
import 'package:movie_app/widgets/Splash_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Future<List<Movie_image>> getnowplaying;
  @override
  void initState(){
    super.initState();
    getnowplaying = Api().getnowplaying();
    Future.delayed(Duration.zero, () async {
    await getnowplaying;
    // await Api().getmovieimage('tt11097384');
    
  });
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return FutureBuilder<List<Movie_image>>(
                future: getnowplaying,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Splash_widget(); 
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); 
                  } else {
                     return Scaffold(
                      appBar: AppBar(
                       title:Text('Welcome, ${FirebaseAuth.instance.currentUser?.displayName}!'),
                       actions: [
                         IconButton(onPressed: ()async{
                          await GoogleSignIn().signOut();
                          FirebaseAuth.instance.signOut();
                          GoRouter.of(context).go('/signin');},
                          icon: Icon(Icons.logout)
                       )],),

              body: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height*0.08,
                          width : width*0.7,
                          child:  TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search movie by name',
                          ),),),
                        MaterialButton(
                          onPressed: () {
                            print(_controller.text);
                          },
                          child: Text('Search'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,1,10,1),
                      child:
                      Text("Playing Now", style: TextStyle(fontSize: 24),),),

                    SizedBox(
                      // height : height,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                            itemCount: 20,
                            options: CarouselOptions(
                              height: height*0.85 ,
                              // aspectRatio: 9/15 ,
                              autoPlay: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              pageSnapping: true,
                              autoPlayCurve: Curves.easeInOutCubicEmphasized,
                              autoPlayAnimationDuration: Duration(seconds: 3),

                            ),

                            itemBuilder: (context,itemIndex, pageViewIndex){
                              return Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: MaterialButton(
                                        onPressed: () async {
                                          GoRouter.of(context).push('/movie-detail/${snapshot.data![itemIndex].id}');
                                        },
                                        child:SizedBox(
                                          width: width,
                                          child: Image.network(
                                            snapshot.data![itemIndex].poster,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                            return Image.asset('assets/images/404_not_found.png', fit: BoxFit.cover);},
                                          ),
                                        ),
                                      ),),
                                    );
                                   
                                  
                                },
                              


                        )
                    ),

                  ],
                ),
              )

          );
        }
            },
          );
                  }
            else {
              GoRouter.of(context).pushReplacement('/signin');
              return Container();
                  }}
          else {
          return Center(
            child: CircularProgressIndicator(),
          );
          }
        },
    );
  }
}