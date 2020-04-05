import 'package:flutter/material.dart';
import './ui/ProfilfeScreen.dart';
import './ui/signUpScreen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Set default home.
  Widget _defaultHome = new ProfileScreen();
  runApp(new MaterialApp(
    title: 'UMS',
    debugShowCheckedModeBanner: false,
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/signup': (BuildContext context) => new SignupPage(),
      '/profile': (BuildContext context) => new ProfileScreen(),
    },
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
