// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel> getUserPresenceStatus({required String uid});

  void updateUserPresence();

  Future<UserModel?> getCurrentUserInfo();

  void saveUserInfoToFirestore({
    required String username,
    required var profileImage,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  });

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  });

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  });
}
