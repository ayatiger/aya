class Message {
  static const String collectionName = 'message';
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;

  Message({
    this.id = '',
    required this.roomId,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.dateTime,
  });

  Message.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    roomId: json['room_id'] as String,
    content: json['content'] as String,
    senderId: json['senderId'] as String,
    senderName: json['senderName'] as String,
    dateTime: json['date_time'] as int,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'date_time': dateTime,
    };
  }
}
