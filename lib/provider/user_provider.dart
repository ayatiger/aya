import 'package:chat/database/database_utils.dart';
import 'package:chat/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;

  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  Future<void> initUser() async {
    if (firebaseUser != null) {
      user = await DatabaseUtils.getUser(firebaseUser?.uid ?? '');
    }
  }
}
