import '../models/status_model.dart';

abstract class StatusRepository {
  Future<void> createStatus(StatusModel status);
  Future<void> updateStatus(StatusModel status);
  Future<void> updateOnlyImageStatus(StatusModel status);
  Future<void> seenStatusUpdate(String statusId, int imageIndex, String userId);
  Future<void> deleteStatus(StatusModel status);
  Stream<List<StatusModel>> getStatuses(StatusModel status);
  Stream<List<StatusModel>> getMyStatus(String uid);
  Future<List<StatusModel>> getMyStatusFuture(String uid);
}
