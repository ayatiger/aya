import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ui/home/home_screen.dart';
import '../widgets/call_widget.dart';
import '../widgets/profile_widget.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AuthInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int currentIndex2 = 0;
  dynamic currentValue;

  List<BottomNavigationBarItem> getTabs(BuildContext context) {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.phone,
        ),
        label: 'call',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined),
        label: 'profile',
      ),
    ];
  }

  List<Widget> screens = [
    const HomeScreen(),
    const CallWidget(),
    const ProfileWidget(),
  ];

  void changeBot(index, context) {
    emit(ChangeBotNavState());
    currentIndex = index;
  }
}
