import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn_google extends StatefulWidget {
  const SignIn_google({super.key});

  @override
  State<SignIn_google> createState() => _SignIn_googleState();
}

class _SignIn_googleState extends State<SignIn_google> {
  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with Google'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.22*width,0,0.05*width,0),
                  child: 
                    Image.asset('assets/images/google_logo.png', height: 0.1*height, width: 0.1*width,),),
                    ElevatedButton(
                      onPressed: () async{
                        await signInWithGoogle();
                        if(FirebaseAuth.instance.currentUser != null){
                          GoRouter.of(context).pushReplacement('/homepage');
                        }
                      },
                      child: Text('Sign In with Google'),
                    ),
                  ],
                ),
              ],
            ),
          
        ),
      
    );
  }
}

signInWithGoogle() async{

  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential= GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  print(userCredential.user?.displayName);
  


}
