import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {




@override
void initState(){
  super.initState();
  _navigate();
}

_navigate()async{
await Future.delayed(Duration(milliseconds: 2500),(){});
final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return
  GoRouter.of(context).pushReplacement('/homepage');
  } else {
  GoRouter.of(context).pushReplacement('/signin');  
  }

}


  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child:
          Container(
            child: Image.asset('assets/images/movie_logo.png', height: height * 0.3, width: width * 0.3,)
            
          ),
        ),
      );



  }
}
