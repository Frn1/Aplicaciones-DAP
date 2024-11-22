// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  String password;

  User(this.username, this.password);

  @override
  bool operator ==(Object other) {
    if (other is User) {
      return username == other.username && password == other.password;
    }
    return this == other;
  }

  static Future<User?> getFromFirebase(String username) async {
    final db = FirebaseFirestore.instance;
    final users = db.collection('users');
    final userDoc = await users.doc(username).get();
    if (userDoc.exists == false) {
      return null;
    }
    return User(userDoc.id, userDoc.get('password'));
  }
  
  
}
