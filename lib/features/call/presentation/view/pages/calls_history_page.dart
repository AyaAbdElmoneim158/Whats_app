import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/core/utils/helper/function_helper.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../../core/shared/widgets/profile_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../data/models/call_model.dart';
import '../../view_model/call_controller.dart';

class CallHistoryPage extends ConsumerWidget {
  final UserModel currentUser;

  const CallHistoryPage({Key? key, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callController = ref.watch(callControllerProvider);

    return FutureBuilder(
      future: callController.getMyCallHistory(currentUser.uid!).first,
      builder: (context, AsyncSnapshot<List<CallModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.greenDark,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final callHistory = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Recent",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.greyLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: callHistory.length,
                  itemBuilder: (context, index) {
                    final singleCallHistory = callHistory[index];
                    return ListTile(
                      leading: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: profileWidget(
                            imageUrl:
                                singleCallHistory.callerId == currentUser.uid
                                    ? singleCallHistory.receiverProfileUrl
                                    : singleCallHistory.callerProfileUrl,
                          ),
                        ),
                      ),
                      title: Text(
                        (singleCallHistory.callerId != null &&
                                currentUser.uid != null &&
                                singleCallHistory.callerId == currentUser.uid)
                            ? singleCallHistory.receiverName ?? 'Unknown'
                            : singleCallHistory.callerName ?? 'Unknown',
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            singleCallHistory.callerId == currentUser.uid
                                ? Icons.call_made
                                : Icons.call_received,
                            color: singleCallHistory.isMissed!
                                ? Colors.red
                                : Colors.green,
                            size: 19,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            FunctionsHelper.formatDateTime(
                                singleCallHistory.createdAt!.toDate()),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.call,
                        color: AppColors.backgroundDark,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No Recent History",
              style: TextStyle(fontSize: 15, color: AppColors.greyLight),
            ),
          );
        }
      },
    );
  }
}
