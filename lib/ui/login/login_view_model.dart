import 'package:chat/database/database_utils.dart';
import 'package:chat/firebase_errors.dart';
import 'package:chat/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;

  void loginFirebaseAuth(String email, String password) async {
    try {
      // show loading
      navigator.showLoading();
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // hide loading
      navigator.hideLoading();
      // show message
      navigator.showMessage('Login Successfully');
      // retrieve data
      var userObj = await DatabaseUtils.getUser(result.user?.uid ?? '');
      if (userObj == null) {
        navigator.hideLoading();
        navigator.showMessage('try again');
      } else {
        navigator.navigateToHome(userObj);
      }
      // navigator.navigateToHome();
      // print('id : ${result.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        // hide loading
        navigator.hideLoading();
        // show loading
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FirebaseErrors.wrongPassword) {
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}
