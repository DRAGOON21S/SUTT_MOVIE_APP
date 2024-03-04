import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Movie_detail extends StatefulWidget {
  const Movie_detail({Key? key}) : super(key: key);

  @override
  _Movie_detailState createState() => _Movie_detailState();
} 

class _Movie_detailState extends State<Movie_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Movie Detail'),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

