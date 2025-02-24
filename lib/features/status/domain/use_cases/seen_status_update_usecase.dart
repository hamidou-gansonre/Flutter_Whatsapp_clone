import 'package:whatsapp_app/features/status/domain/repositories/status_repository.dart';

class SeenStatusUpdateUseCase {

  final StatusRepository repository;

  const SeenStatusUpdateUseCase({required this.repository});

  Future<void> call(String statusId, int imageIndex, String userId) async {
    return await repository.seenStatusUpdate(statusId, imageIndex, userId);
  }
}