import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ninja_brew_crew_coffre/home/home.dart';
import 'package:ninja_brew_crew_coffre/models/user.dart';
import 'package:ninja_brew_crew_coffre/screen/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print('$user blah');
    return Scaffold(
      body: user == null ? Authenticate() : Home(),
    );
  }
}
