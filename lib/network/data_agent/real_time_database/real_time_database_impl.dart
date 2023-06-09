import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_chat/data/vos/message_vo/message_vo.dart';
import 'package:we_chat/data/vos/post_vo/post_vo.dart';
import 'package:we_chat/network/data_agent/real_time_database/real_time_database.dart';

import '../../../constant/strings.dart';

class RealTimeDatabaseImpl extends RealTimeDataBase {
  RealTimeDatabaseImpl._();

  static final _singleton = RealTimeDatabaseImpl._();

  factory RealTimeDatabaseImpl() => _singleton;

  final _database = FirebaseDatabase.instance.ref();
  var auth = FirebaseAuth.instance;

  @override
  Future sendMessage(String friendId, MessageVO messageVO) {
    _database
        .child(kRootNodeForMessages)
        .child(auth.currentUser?.uid ?? '')
        .child(friendId)
        .child(messageVO.messageId ?? '')
        .set(messageVO.toJson());

    return _database
        .child(kRootNodeForMessages)
        .child(friendId)
        .child(auth.currentUser?.uid ?? '')
        .child(messageVO.messageId ?? '')
        .set(messageVO.toJson());
  }

  @override
  Stream<List<MessageVO>?> getMessages(String friendId) => _database
          .child(kRootNodeForMessages)
          .child(auth.currentUser?.uid ?? '')
          .child(friendId)
          .onValue
          .map((event) {
        return event.snapshot.children.map((e) {
          return MessageVO.fromJson(Map<String, dynamic>.from(e.value as Map));
        }).toList();
      });

  @override
  Stream<List<String>?> getChattingFriends() => _database
          .child(kRootNodeForMessages)
          .child(auth.currentUser?.uid ?? '')
          .onValue
          .map((event) {
        return event.snapshot.children.map((e) {
          return e.key!;
        }).toList();
      });

  @override
  Future<MessageVO> getLastMessage(String friendId) {
    return getMessages(friendId).first.then((value) => value!.last);
  }

  @override
  Future<void> deleteMessage(String friendId, String messageId) {
    _database
        .child(kRootNodeForMessages)
        .child(auth.currentUser?.uid ?? '')
        .child(friendId)
        .child(messageId)
        .remove();

    return _database
        .child(kRootNodeForMessages)
        .child(friendId)
        .child(auth.currentUser?.uid ?? '')
        .child(messageId)
        .remove();
  }

  @override
  Future<void> createPost(PostVO post)=>_database
      .child(kRootNodeForPosts)
      .child(auth.currentUser?.uid ?? '')
      .child(post.postId??'')
      .set(post.toJson());
}
