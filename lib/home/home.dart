import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ninja_brew_crew_coffre/home/brew_list.dart';
import 'package:ninja_brew_crew_coffre/home/settings_form.dart';
import 'package:ninja_brew_crew_coffre/models/brew.dart';
import 'package:ninja_brew_crew_coffre/services/auth.dart';
import 'package:ninja_brew_crew_coffre/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Brew?>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Log out'),
              icon: Icon(Icons.person),
            ),
            TextButton.icon(
              onPressed: () {
                _showSettingPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/coffee_bg.png'))),
            child: BrewList()),
      ),
    );
  }
}
