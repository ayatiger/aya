import 'package:chat/database/database_utils.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebase_errors.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

  void registerFirebaseAuth(String email, String password, String firstName,
      String lastName, String userName) async {
    navigator.showLoading();
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = MyUser(
          id: result.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      var dataUser = await DatabaseUtils.regesterUser(user);
      // save data
      navigator.hideLoading();
      navigator.showMessage('Registered successfully');
      navigator.navigateToHome(user);
      //  print('Firebase user id : ${result.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak.');
        //print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
        navigator.showLoading();
        navigator.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage('something went wrong');
      print(e);
    }
  }
}
