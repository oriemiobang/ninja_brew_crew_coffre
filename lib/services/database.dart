import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_brew_crew_coffre/models/brew.dart';
import 'package:ninja_brew_crew_coffre/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    // brewCollection.d
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snopshot

  List<Brew> _brewListFromSnopshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      return Brew(
          name: data?['name'] ?? '',
          sugars: data?['sugars'] ?? '0',
          strength: data?['strength'] ?? 0);
    }).toList();
  }

  Stream<List<Brew?>?> get brews {
    return brewCollection.snapshots().map(_brewListFromSnopshot);
  }

  // useData from snopshot
  UserData _userDataFromSnopshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    print(data);
    // print(uid);

    return UserData(
      uid: uid,
      name: data!['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 0,
    );
  }

  // get user doc stream
  Stream<UserData?> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnopshot);
  }
}
