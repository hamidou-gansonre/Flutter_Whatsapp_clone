
import 'package:whatsapp_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_app/features/status/domain/repositories/status_repository.dart';

class GetStatusesUseCase {

  final StatusRepository repository;

  const GetStatusesUseCase({required this.repository});

  Stream<List<StatusEntity>> call(StatusEntity status) {
    return repository.getStatuses(status);
  }
}