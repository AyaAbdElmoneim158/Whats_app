// ignore_for_file: deprecated_member_use
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/status_model.dart';
import '../../data/repo/status_repository.dart';
import '../../data/repo/status_repository_impl.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.watch(statusRepositoryProvider);
  return StatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;

  StatusController({required this.statusRepository, required this.ref});

  Future<void> getStatuses({required StatusModel status}) async =>
      statusRepository.getStatuses(status);
  Future<void> createStatus({required StatusModel status}) async =>
      statusRepository.createStatus(status);
  Future<void> deleteStatus({required StatusModel status}) async =>
      statusRepository.deleteStatus(status);
  Future<void> updateStatus({required StatusModel status}) async =>
      statusRepository.updateStatus(status);
  Future<void> updateOnlyImageStatus({required StatusModel status}) async =>
      statusRepository.updateOnlyImageStatus(status);
  Future<void> seenStatusUpdate({
    required String statusId,
    required int imageIndex,
    required String userId,
  }) async =>
      statusRepository.seenStatusUpdate(statusId, imageIndex, userId);
  Future<void> getMyStatus({required String uid}) async =>
      statusRepository.getMyStatus(uid);
}
