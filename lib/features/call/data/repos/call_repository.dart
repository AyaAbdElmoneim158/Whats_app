import 'package:flutter/material.dart';

import '../models/call_model.dart';

abstract class CallRepository {
  Future<void> makeCall(CallModel call, BuildContext context);
  Future<void> endCall(CallModel call, BuildContext context);
  Future<void> updateCallHistoryStatus(CallModel call);

  Future<void> saveCallHistory(CallModel call, BuildContext context);
  Stream<List<CallModel>> getUserCalling(String uid);
  Stream<List<CallModel>> getMyCallHistory(String uid);
  Future<String> getCallChannelId(String uid);
}
