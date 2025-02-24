import 'package:whatsapp_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_app/features/status/domain/repositories/status_repository.dart';

class DeleteStatusUseCase {

  final StatusRepository repository;

  const DeleteStatusUseCase({required this.repository});

  Future<void> call(StatusEntity status) async {
    return await repository.deleteStatus(status);
  }
}