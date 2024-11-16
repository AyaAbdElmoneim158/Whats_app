import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/models/last_message_model.dart';
import '../../../../core/shared/models/message_model.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../../../core/utils/constants/app_enums.dart';

abstract class ChatRepository {
  void sendFileMessage({
    required var file,
    required BuildContext context,
    required String receiverId,
    required UserModel senderData,
    required Ref ref,
    required MessageType messageType,
  });

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId);

  Stream<List<LastMessageModel>> getAllLastMessageList();

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
    required UserModel senderData,
  });

  void saveToMessageCollection({
    required String receiverId,
    required String textMessage,
    required DateTime timeSent,
    required String textMessageId,
    required String senderUsername,
    required String receiverUsername,
    required MessageType messageType,
  });

  void saveAsLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String lastMessage,
    required DateTime timeSent,
    required String receiverId,
  });
}
