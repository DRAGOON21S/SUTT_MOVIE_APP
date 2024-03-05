

class Movie_now{
  String  title;
  String id;

  Movie_now({
    required this.title,
    required this.id,
});

  factory Movie_now.fromJson(Map<String, dynamic> json){
    return Movie_now(
      title : json["title"],
      id: json["imdb_id"],
    );
  }

}

// appBar: AppBar(
//                   title:Text('Welcome, ${FirebaseAuth.instance.currentUser?.displayName}!'),
//                   actions: [
//                     IconButton(onPressed: ()async{
//                       await GoogleSignIn().signOut();
//                       FirebaseAuth.instance.signOut();
//                       GoRouter.of(context).go('/signin');},
//                       icon: Icon(Icons.logout)
//                     )],),