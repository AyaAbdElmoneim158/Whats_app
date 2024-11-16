import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agora_uikit/agora_uikit.dart';

final agoraModelProvider = Provider((ref) {
  return AgoraModel(ref);
});

class AgoraModel {
  // ignore: deprecated_member_use
  final ProviderRef ref;
  AgoraClient? _client;
  AgoraModel(this.ref);

  Future<void> initialize({String? tokenUrl, String? channelName}) async {
    if (_client == null) {
      _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "7f97c3fcda294c3c989307de9873e5d3",
          channelName: channelName!,
          tokenUrl: tokenUrl,
        ),
      );
      await _client!.initialize();
    }
  }

  Future<void> leaveChannel() async {
    if (_client != null) {
      await _client!.engine.leaveChannel();
      await _client!.engine.release();
      _client = null;
    }
  }

  AgoraClient? get getAgoraClient => _client;
}
