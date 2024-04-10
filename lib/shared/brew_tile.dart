import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:ninja_brew_crew_coffre/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              radius: 25,
              backgroundColor: Colors.brown[brew.strength]),
          title: Text('${brew.name}'),
          subtitle: Text('Takes ${brew.sugars} sugars(s)'),
        ),
      ),
    );
  }
}
