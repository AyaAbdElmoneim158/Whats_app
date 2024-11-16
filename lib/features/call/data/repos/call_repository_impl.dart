import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/helper/function_helper.dart';
import '../models/call_model.dart';
import 'call_repository.dart';

final callRepositoryProvider = Provider((ref) {
  return CallRepositoryImpl(
    fireStore: FirebaseFirestore.instance,
  );
});

class CallRepositoryImpl implements CallRepository {
  final FirebaseFirestore fireStore;
  CallRepositoryImpl({required this.fireStore});

  @override
  Future<void> endCall(
    CallModel call,
    BuildContext context,
  ) async {
    final callCollection = fireStore.collection("call");
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
    } catch (e) {
      FunctionsHelper.showAlertDialog(context: context, message: e.toString());
    }
  }

  @override
  Future<String> getCallChannelId(String uid) async {
    final callCollection = fireStore.collection("call");

    return callCollection.doc(uid).get().then((callConnection) {
      if (callConnection.exists) {
        return callConnection.data()!['callId'];
      }
      return Future.value("");
    });
  }

  @override
  Stream<List<CallModel>> getMyCallHistory(String uid) {
    final myHistoryCollection = fireStore
        .collection("users")
        .doc(uid)
        .collection("callHistory")
        .orderBy("createdAt", descending: true);

    return myHistoryCollection.snapshots().map((querySnapshots) =>
        querySnapshots.docs.map((e) => CallModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<CallModel>> getUserCalling(String uid) {
    final callCollection = fireStore.collection("call");
    return callCollection
        .where("callerId", isEqualTo: uid)
        .limit(1)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => CallModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> makeCall(CallModel call, BuildContext context) async {
    final callCollection = fireStore.collection("call");

    String callId = callCollection.doc().id;

    final callerData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: callId,
      isCallDialed: true,
      isMissed: false,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    final receiverData = CallModel(
      callerId: call.receiverId,
      callerName: call.receiverName,
      callerProfileUrl: call.receiverProfileUrl,
      callId: callId,
      isCallDialed: false,
      isMissed: false,
      receiverId: call.callerId,
      receiverName: call.callerName,
      receiverProfileUrl: call.callerProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    try {
      await callCollection.doc(call.callerId).set(callerData);
      await callCollection.doc(call.receiverId).set(receiverData);
    } catch (e) {
      FunctionsHelper.showAlertDialog(context: context, message: e.toString());
    }
  }

  @override
  Future<void> saveCallHistory(CallModel call, BuildContext context) async {
    final myHistoryCollection = fireStore
        .collection("users")
        .doc(call.callerId)
        .collection("callHistory");
    final otherHistoryCollection = fireStore
        .collection("users")
        .doc(call.receiverId)
        .collection("callHistory");

    final callData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: call.callId,
      isCallDialed: call.isCallDialed,
      isMissed: call.isMissed,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    try {
      await myHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
      await otherHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
    } catch (e) {
      FunctionsHelper.showAlertDialog(context: context, message: e.toString());
    }
  }

  @override
  Future<void> updateCallHistoryStatus(CallModel call) async {
    final myHistoryCollection = fireStore
        .collection("users")
        .doc(call.callerId)
        .collection("callHistory");
    final otherHistoryCollection = fireStore
        .collection("users")
        .doc(call.receiverId)
        .collection("callHistory");

    Map<String, dynamic> myHistoryInfo = {};
    Map<String, dynamic> otherHistoryInfo = {};

    if (call.isCallDialed != null) {
      myHistoryInfo['isCallDialed'] = call.isCallDialed;
    }
    if (call.isMissed != null) myHistoryInfo['isMissed'] = call.isMissed;

    if (call.isCallDialed != null) {
      otherHistoryInfo['isCallDialed'] = call.isCallDialed;
    }
    if (call.isMissed != null) otherHistoryInfo['isMissed'] = call.isMissed;

    myHistoryCollection.doc(call.callId).update(myHistoryInfo);
    otherHistoryCollection.doc(call.callId).update(otherHistoryInfo);
  }
}
