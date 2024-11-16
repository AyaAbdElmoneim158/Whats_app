import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_messenger/core/theme/custom_theme_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_picker/giphy_picker.dart';
import '../constants/app_colors.dart';

class FunctionsHelper {
  FunctionsHelper._();

  // Last Seen Message Formatter -----------------------------------------
  static String lastSeenMessage(lastSeen) {
    DateTime now = DateTime.now();
    Duration differenceDuration = now.difference(
      DateTime.fromMillisecondsSinceEpoch(lastSeen),
    );

    String finalMessage = differenceDuration.inSeconds > 59
        ? differenceDuration.inMinutes > 59
            ? differenceDuration.inHours > 23
                ? "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}"
                : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}"
            : "${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}"
        : 'few moments';

    return finalMessage;
  }

  // Show Alert Dialog ---------------------------------------------------
  static showAlertDialog({
    required BuildContext context,
    required String message,
    String? btnText,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(
              color: context.theme.greyColor,
              fontSize: 15,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                btnText ?? "OK",
                style: TextStyle(
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show Loading Dialog -------------------------------------------------
  static showLoadingDialog({
    required BuildContext context,
    required String message,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const CircularProgressIndicator(
                    color: AppColors.greenDark,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 15,
                        color: context.theme.greyColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Toast -------------------------------------------------
  static void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: const Color.fromRGBO(0, 167, 131, 1),
      textColor: Colors.white,
    );
  }

  // PickGIF -------------------------------------------------
  static Future<GiphyGif?> pickGIF(BuildContext context) async {
    GiphyGif? gif;
    try {
      gif = await GiphyPicker.pickGif(
          context: context, apiKey: 'kLu4PIKAwS2ys47Ji7oWUIr2iZbEoj1k');
    } catch (e) {
      toast(e.toString());
    }

    return gif;
  }

  static String formatDateTime(DateTime dateTime) {
    final today = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    final timeFormatter = DateFormat('h:mm a');

    if (dateTime.year == today.year &&
        dateTime.month == today.month &&
        dateTime.day == today.day) {
      return 'Today, ${timeFormatter.format(dateTime)}';
    } else if (dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day) {
      return 'Tomorrow, ${timeFormatter.format(dateTime)}';
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return 'Yesterday, ${timeFormatter.format(dateTime)}';
    } else {
      final dateFormatter = DateFormat('MMM d');
      return '${dateFormatter.format(dateTime)}, ${timeFormatter.format(dateTime)}';
    }
  }
}
