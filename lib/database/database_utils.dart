import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toJson());
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, options) =>
                Room.fromJson(snapshot.data()!),
            toFirestore: (room, options) => room.toJson());
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: ((snapshot, options) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (message, options) => message.toJson());
  }

  static Future<void> regesterUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userId) async {
    var documentSnapShot = await getUserCollection().doc(userId).get();
    return documentSnapShot.data();
  }

  static Future<void> addRoomToFirestore(Room room) async {
    var docRef = await getRoomCollection().doc();
    room.roomId = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms() {
    return getRoomCollection().snapshots();
  }

  static Future<void> insertMessage(Message message) async {
    var messageCollection = getMessageCollection(message.roomId);
    var docRef = messageCollection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessagesFromFireStore(
      String roomId) {
    return getMessageCollection(roomId)
        .orderBy(
          'date_time',
        )
        .snapshots();
  }
}
