import 'dart:io';
import 'package:flutter/material.dart';
import 'package:personal_expanses_app/screens/home_screen.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp
  //   ]
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(fontFamily: 'OpenSans',fontWeight:FontWeight.bold,fontSize: 18 )
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle:TextStyle(fontFamily:'OpenSans',fontSize: 20,color:Colors.white,
          fontWeight: FontWeight.bold),
        ),
      ),
      home:  HomeScreen(),
    );
  }
}



