import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../constants/colors.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey.withOpacity(.5),
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 18),
              iconSize: 30,
              onTap: (index) => cubit.changeBot(index, context),
              items: cubit.getTabs(context),
            ),
          ),
        );
      },
    );
  }
}
