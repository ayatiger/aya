import 'package:chat/chat/chat_navigator.dart';
import 'package:chat/chat/chat_screen_view_model.dart';
import 'package:chat/model/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/utils.dart' as Utils;

import '../model/message.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  // https://flutter.dev/docs/testing/errors
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    viewModel.listenForUpdateMessages();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(args.title),
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.streamMessage,
                  builder: (context, asyncSnapShot) {
                    if (asyncSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (asyncSnapShot.hasError) {
                      return Text(asyncSnapShot.error.toString());
                    } else {
                      var messageList = asyncSnapShot.data?.docs
                              .map((doc) => doc.data())
                              .toList() ??
                          [];
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(message: messageList[index]);
                        },
                        itemCount: messageList.length,
                      );
                    }
                  },
                )),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      onChanged: (text) {
                        messageContent = text;
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)))),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(messageContent);
                        },
                        child: const Row(
                          children: [
                            Text('Send'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.send_outlined)
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message, context, 'OK', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage() {
    controller.clear();
  }
}
