import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/models/movie_image.dart';
import 'package:movie_app/widgets/Splash_widget.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    final controller = TextEditingController();
    return Scaffold( 
      appBar: AppBar(title: const Text('search')),
      body:
        Container(
          height:height*0.1,
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(8)
          ),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:height*0.9,
                width:width*0.8,
                child:
                  TextField(
                    
                    controller: controller,
                    decoration: const InputDecoration(
                    
                    labelText: 'Search movie by name',
                    ),
                    autofocus: true),),
                  IconButton(
                    onPressed: () async{
                      GoRouter.of(context).push('/search-result/${controller.text}');
                    },
                    icon:const Icon(Icons.search)
                  ),
                ],
              ),
            
          
      
    ));
  }
}

class Search_result extends StatefulWidget {
  String name;
  Search_result({required this.name});

  @override
  State<Search_result> createState() => _Search_resultState();
}

class _Search_resultState extends State<Search_result> {

  late Future<List<Movie_image>> getresults;
  late List<Movie_image> list2;
  @override
  void initState(){
    getresults=Api().getmovieresult(widget.name);
    Future.delayed(Duration.zero, () async {
    await getresults;
    list2 = await getresults;});
    
    // print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie_image>>(
                future: getresults,
                builder: (context, snapshot) {
                  
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Splash_widget(); 
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); 
                  } else {
                      return Scaffold(
                        appBar: AppBar(
                          leading: IconButton(onPressed: ()=>context.pop(), icon: Icon(Icons.arrow_back)),
                          title: Text('Search results'),
                        ),
                        // body: 
                        body:Expanded(
                          child: ListView.builder(
                            
                            itemCount: list2.length,
                            itemBuilder: (context,index){
                              if(snapshot.data![0].title==''){
                                return const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text('No matches found')
                                );
                              }
                              else {
                                return Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: ListTile(
                                  title: Text(snapshot.data![index].title),
                                  leading: Image.network(snapshot.data![index].poster,
                                  errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/movie__logo.png', fit: BoxFit.cover);},),
                                  tileColor: Colors.blueGrey[900],
                                  hoverColor: Colors.blueGrey[700],
                                  onTap: () async{
                                    GoRouter.of(context).push('/movie-detail/${snapshot.data![index].id}');
                                  },
                                )
                              );}
          }
          ),
      )
    );
  }});
}}
