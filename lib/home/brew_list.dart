import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ninja_brew_crew_coffre/models/brew.dart';
import 'package:ninja_brew_crew_coffre/shared/brew_tile.dart';
import 'package:ninja_brew_crew_coffre/shared/loading.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew?>?>(context);

    brews?.forEach((element) {
      print(element?.name);
      print(element?.sugars);
      print(element?.strength);
    });
    // } else {

    // }
    return brews != null
        ? ListView.builder(
            itemCount: brews.length,
            itemBuilder: (BuildContext context, int index) {
              return BrewTile(
                brew: brews[index]!,
              );
            },
          )
        : Loading();
  }
}
