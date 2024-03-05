import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import './main.dart';
// import './homepage.dart';


class Splash_widget extends StatefulWidget {
  const Splash_widget({super.key});

  @override
  State<Splash_widget> createState() => _SplashState();
}
class _SplashState extends State<Splash_widget> {
@override



  @override
  Widget build(BuildContext context) {
    // dynamic height = MediaQuery.of(context).size.height;
    // dynamic width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
            // child: Image.asset('assets/images/movie_logo.png', height: height * 0.3, width: width * 0.3,)
            child: RotatingImage(
            image: AssetImage('assets/images/movie_logo.png'),
            duration: Duration(seconds: 1),
          ),
          
        ),
      );
      



  }
}

// import 'dart:ui';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Rotating Image')),
//         body: Center(
//           child: RotatingImage(
//             image: AssetImage('assets/images/flutter_logo.png'),
//             duration: Duration(seconds: 2),
//           ),
//         ),
//       ),
//     );
//   }
// }

class RotatingImage extends StatefulWidget {
  final ImageProvider image;
  final Duration duration;

  RotatingImage({required this.image, required this.duration});

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic height = MediaQuery.of(context).size.height;
    dynamic width = MediaQuery.of(context).size.width;
    return RotationTransition(
      turns: _controller,
      child: Image(image: widget.image,height: height * 0.23, width: width * 0.23,),
    );
  }
}