// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/core/routing/routes.dart';

import '../../../../../core/shared/widgets/profile_widget.dart';
import '../../../data/models/call_model.dart';
import '../../view_model/agora_controller.dart';
import '../../view_model/call_controller.dart';

class PickUpCallPage extends ConsumerStatefulWidget {
  final String? uid;
  final Widget child;

  const PickUpCallPage({Key? key, required this.child, this.uid})
      : super(key: key);

  @override
  ConsumerState<PickUpCallPage> createState() => _PickUpCallPageState();
}

class _PickUpCallPageState extends ConsumerState<PickUpCallPage> {
  late final Stream<List<CallModel>> callStream;

  @override
  void initState() {
    super.initState();
    callStream = ref.read(callControllerProvider).getUserCalling(widget.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CallModel>>(
      stream: callStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final call = snapshot.data!.firstWhere((c) => c.isCallDialed == false,
              orElse: () => CallModel());

          if (call.isCallDialed == false) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Incoming Call',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  profileWidget(imageUrl: call.receiverProfileUrl),
                  const SizedBox(height: 40),
                  Text(
                    call.receiverName ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(agoraModelProvider)
                              .leaveChannel()
                              .then((_) async {
                            await ref
                                .read(callControllerProvider)
                                .updateCallHistoryStatus(CallModel(
                                  callId: call.callId,
                                  callerId: call.callerId,
                                  receiverId: call.receiverId,
                                  isCallDialed: false,
                                  isMissed: true,
                                ));
                            await ref.read(callControllerProvider).endCall(
                                CallModel(
                                  callerId: call.callerId,
                                  receiverId: call.receiverId,
                                ),
                                context);
                          });
                        },
                        icon:
                            const Icon(Icons.call_end, color: Colors.redAccent),
                      ),
                      const SizedBox(width: 25),
                      IconButton(
                        onPressed: () async {
                          final callChannelId = await ref
                              .read(callControllerProvider)
                              .getCallChannelId(call.receiverId!);
                          Navigator.pushNamed(
                            context,
                            Routes.callPage,
                            arguments: CallModel(
                              callId: callChannelId,
                              callerId: call.callerId!,
                              receiverId: call.receiverId!,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }

        // Return the child widget if no call is available
        return widget.child;
      },
    );
  }
}
