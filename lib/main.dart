import 'package:cupoappfinal/homepage.dart';
import 'package:cupoappfinal/services/logonservice.dart';
import 'package:cupoappfinal/todo/screems/home_screem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Provider(
    create: (_) => LoginService(),
    child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/todo': (context) => HomeScreen(),
        // '/login': (context) => LoginScreen(),
        // '/homescreen': (context) => HomeScreen(),
      },
    ),
  ));
}
