import 'dart:ffi';

import 'package:flutter/material.dart';

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
            Column(
              children: [
                Image.asset('images/google_logo.png', height: 0.2*height, width: 0.2*width,),
                ElevatedButton(
                  onPressed: () {
                    
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