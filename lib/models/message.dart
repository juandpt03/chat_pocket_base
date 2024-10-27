class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String content;
  final String created;
  final String updated;

  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.created,
    required this.updated,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      content: json['content'] ?? '',
      created: json['created'] ?? '',
      updated: json['updated'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'created': created,
      'updated': updated,
    };
  }
}
