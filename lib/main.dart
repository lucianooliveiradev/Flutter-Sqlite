import 'package:flutter/material.dart';
import 'package:todolist/Pages/addressPage.dart';
import 'package:todolist/Pages/configurationPage.dart';
import 'package:todolist/Pages/itemPage.dart';
import 'package:todolist/Pages/messages.dart';
import 'package:todolist/Pages/profilePage.dart';
import 'Pages/homePage.dart';
import 'Pages/User/userPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Home'),
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(title: "Home"),
        '/users': (context) => UserPage(),
        '/profiles': (context) => ProfilePage(),
        '/addresses': (context) => AddressPage(),
        '/messages': (context) => MessagePage(),
        '/configurations': (context) => ConfigurationPage(),
        '/items': (context) => ItemPage(),
      },
    );
  }
}
