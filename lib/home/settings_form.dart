import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew_coffre/models/user.dart';
import 'package:ninja_brew_crew_coffre/services/database.dart';
import 'package:ninja_brew_crew_coffre/shared/constant.dart';
import 'package:ninja_brew_crew_coffre/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  String _currentName = '';
  String _currentSugar = '';
  int _currentStrength = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Udate your brew setttings',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        initialValue: userData?.name,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() {
                              _currentName = val;
                            }),
                        decoration: textInputDecoration),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugar == ''
                            ? userData!.sugars
                            : _currentSugar,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _currentSugar = val!;
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Slider(
                        activeColor: Colors.brown[_currentStrength == 0
                            ? userData!.strength!
                            : _currentStrength],
                        inactiveColor: Colors.brown[_currentStrength],
                        min: 100,
                        max: 900,
                        divisions: 8,
                        value: _currentStrength == 0
                            ? userData!.strength!.toDouble()
                            : _currentStrength.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            _currentStrength = val.round();
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color?>(Colors.pink)),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _formkey.currentState!.save();
                            });
                            await DatabaseService(uid: user!.uid)
                                .updateUserData(
                                    _currentSugar == ''
                                        ? userData!.sugars!
                                        : _currentSugar,
                                    _currentName == ''
                                        ? userData!.name!
                                        : _currentName,
                                    _currentStrength == 0
                                        ? userData!.strength!
                                        : _currentStrength);
                          }
                          Navigator.pop(context);
                          print(_currentName);
                          print(_currentSugar);
                          print(_currentStrength);
                        },
                        child: Text(
                          'update',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ));
          } else {
            print(snapshot.data);
            print('${user?.uid} use uid');
            return Loading();
          }
        });
  }
}
