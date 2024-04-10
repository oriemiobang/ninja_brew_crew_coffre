// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew_coffre/firebase_options.dart';
import 'package:ninja_brew_crew_coffre/models/user.dart';
// import 'package:ninja_brew_crew_coffre/screen/authenticate/authenticate.dart';
import 'package:ninja_brew_crew_coffre/screen/wrapper.dart';
import 'package:ninja_brew_crew_coffre/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // MyUser myUser = MyUser();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(home: Wrapper()));
  }
}
