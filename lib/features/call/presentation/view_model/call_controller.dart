// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/call_model.dart';
import '../../data/repos/call_repository.dart';
import '../../data/repos/call_repository_impl.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.watch(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    ref: ref,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;

  CallController({required this.callRepository, required this.ref});

  Future<void> makeCall(CallModel call, BuildContext context) async =>
      callRepository.makeCall(call, context);
  Future<void> endCall(CallModel call, BuildContext context) async =>
      callRepository.endCall(call, context);
  Future<void> updateCallHistoryStatus(CallModel call) async =>
      callRepository.updateCallHistoryStatus(call);

  Future<void> saveCallHistory(CallModel call, BuildContext context) async =>
      callRepository.saveCallHistory(call, context);
  Stream<List<CallModel>> getUserCalling(String uid) =>
      callRepository.getUserCalling(uid);
  Stream<List<CallModel>> getMyCallHistory(String uid) =>
      callRepository.getMyCallHistory(uid);
  Future<String> getCallChannelId(String uid) =>
      callRepository.getCallChannelId(uid);
}
