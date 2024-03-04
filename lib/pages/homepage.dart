import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('Homepage'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // context.go('/movie-detail');
                  GoRouter.of(context).go('/movie-detail');
                },
                child: Text('movie details'),
              ),
            ),

      ])),
    );
  }
}