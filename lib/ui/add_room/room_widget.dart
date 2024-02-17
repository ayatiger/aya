import 'package:chat/chat/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/room.dart';

class RoomWidgit extends StatelessWidget {
  Room room;

  RoomWidgit({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: room);
      },
      child: Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset('assets/images/${room.categoryId}.png',
                height: 80, fit: BoxFit.fill),
            const SizedBox(
              height: 10,
            ),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}
