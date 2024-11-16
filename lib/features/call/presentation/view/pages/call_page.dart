// ignore_for_file: use_build_context_synchronously

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/call_model.dart';
import '../../view_model/agora_controller.dart';
import '../../view_model/call_controller.dart';

class CallPage extends ConsumerStatefulWidget {
  final CallModel callModel;
  const CallPage({Key? key, required this.callModel}) : super(key: key);

  @override
  ConsumerState<CallPage> createState() => _CallPageState();
}

class _CallPageState extends ConsumerState<CallPage> {
  @override
  void initState() {
    ref.read(agoraModelProvider).initialize(
        channelName: widget.callModel.callId!,
        tokenUrl:
            "http://192.168.244.3:3000/get_token?channelName=${widget.callModel.callId}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agoraProvider = ref.read(agoraModelProvider);

    return Scaffold(
      body: agoraProvider.getAgoraClient == null
          ? const Center(
              child: CircularProgressIndicator(
                  // color: tabColor,
                  ),
            )
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: agoraProvider.getAgoraClient!),
                  AgoraVideoButtons(
                    client: agoraProvider.getAgoraClient!,
                    disconnectButtonChild: IconButton(
                      color: Colors.red,
                      onPressed: () async {
                        await agoraProvider.leaveChannel().then((value) {
                          ref.read(callControllerProvider).endCall(
                                CallModel(
                                  callerId: widget.callModel.callerId,
                                  receiverId: widget.callModel.receiverId,
                                ),
                                context,
                              );
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.call_end),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
