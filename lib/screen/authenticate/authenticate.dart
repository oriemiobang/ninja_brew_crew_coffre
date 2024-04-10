import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ninja_brew_crew_coffre/screen/authenticate/register.dart';
import 'package:ninja_brew_crew_coffre/screen/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSingIn = true;

  void toggleView() {
    setState(() {
      showSingIn = !showSingIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSingIn == true
        ? SignIn(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
