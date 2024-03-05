import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/routes/go_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor:  hexToColor('#010123'),
      primaryColorDark:Colors.blue ,
      canvasColor: Colors.green,
      primarySwatch: Colors.red,
    ),
    debugShowCheckedModeBanner: false,
    routerConfig: MyAppRoutes().router,
    // routeInformationParser: MyAppRoutes().router.routeInformationParser,
    // routeInformationProvider: MyAppRoutes().router.routeInformationProvider,
    // routerDelegate: MyAppRoutes().router.routerDelegate,

    
    );
  }
}

Color hexToColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}