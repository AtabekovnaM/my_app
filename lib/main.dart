import 'package:flutter/material.dart';
import 'package:my_app/pages/entry_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/reset_page.dart';
import 'package:my_app/pages/signup_page.dart';


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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EntryPage(),
      routes: {
        EntryPage.id: (context) => EntryPage(),
        LogInPage.id: (context) => LogInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        Profile_Page.id: (context) => Profile_Page(),
        ResetPage.id: (context) => ResetPage()
      },
    );
  }
}
