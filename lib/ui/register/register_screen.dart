import 'dart:async';
import 'package:chat/model/my_user.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/register/register_navigator.dart';
import 'package:chat/ui/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chat/utils.dart' as Utils;
import 'package:provider/provider.dart';
import '../../constants/components.dart';
import '../../constants/transitions.dart';
import '../../network/local/cache_helper.dart';
import '../../view/bottom_nav/bottom_nav_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  String firstName = '';

  String lastName = '';

  dynamic userName = '';

  dynamic email = '';

  dynamic password = '';
  dynamic type = '';
  dynamic disease = '';
  dynamic currentValue1;
  var formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset('assets/images/main_background.png',
              fit: BoxFit.fill, width: double.infinity),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Create Account',
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(217, 217, 217, 1)),
                          ),
                          labelStyle: const TextStyle(color: Colors.white),
                          labelText: 'First Name',
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          firstName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(217, 217, 217, 1)),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (text) {
                          lastName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'User Name',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (text) {
                          userName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          if (!emailValid) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Password'),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 chars.';
                          }
                          return null;
                        },
                      ),
                      DropdownButton<String>(
                        value: currentValue1,
                        onChanged: (newValue) {
                          setState(() {
                            currentValue1 = newValue!;
                            type = newValue;
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'doctor',
                            child: Text('Doctor'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'patient',
                            child: Text('Patient'),
                          ),
                        ],
                      ),
                      TFF(
                        action: TextInputAction.send,
                        type: TextInputType.text,
                        isPrefix: false,
                        underlineBorder: true,
                        label: "Disease",
                        hint: "enter your disease if you are a patient",
                        isEnabledBorder: true,
                        onChanged: (value){
                          disease = value;
                        },
                        borderColor: Colors.grey,
                        labelColor: Colors.grey,
                        validator: (text) {
                          if(currentValue1 == "patient"){
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter last name';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(currentValue1 == null){
                             buildSnackBar('select your type first', context, 3);
                          }
                          else{validateForm();}
                        },
                        child: const Text('Create Account'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> validateForm() async {
    if (formKey.currentState?.validate() == true) {
      CacheHelper.saveData(key: 'email', value: email);
      CacheHelper.saveData(key: 'name', value: firstName + " " + lastName);
      CacheHelper.saveData(key: 'type', value: type);
      CacheHelper.saveData(key: 'disease', value: disease);
      viewModel.registerFirebaseAuth(
          email, password, firstName, lastName, userName);
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    Utils.showMessage(message, context, 'Ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.user = user;
    // TODO: implement navigateToHome
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(CustomPageRoute(child: const AppLayout()));
    });
  }
}
