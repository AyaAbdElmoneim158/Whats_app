import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  final String? callId;
  final String? callerId;
  final String? callerName;
  final String? callerProfileUrl;

  final String? receiverId;
  final String? receiverName;
  final String? receiverProfileUrl;
  final bool? isCallDialed;
  final bool? isMissed;
  final Timestamp? createdAt;

  CallModel({
    this.callId,
    this.callerId,
    this.callerName,
    this.callerProfileUrl,
    this.receiverId,
    this.receiverName,
    this.receiverProfileUrl,
    this.isCallDialed,
    this.isMissed,
    this.createdAt,
  });

  factory CallModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return CallModel(
      receiverProfileUrl: snap['receiverProfileUrl'],
      receiverName: snap['receiverName'],
      receiverId: snap['receiverId'],
      isCallDialed: snap['isCallDialed'],
      callId: snap['callId'],
      callerProfileUrl: snap['callerProfileUrl'],
      callerName: snap['callerName'],
      callerId: snap['callerId'],
      isMissed: snap['isMissed'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "receiverProfileUrl": receiverProfileUrl,
        "receiverName": receiverName,
        "receiverId": receiverId,
        "isCallDialed": isCallDialed,
        "callId": callId,
        "callerProfileUrl": callerProfileUrl,
        "callerName": callerName,
        "callerId": callerId,
        "isMissed": isMissed,
        "createdAt": createdAt,
      };
}
