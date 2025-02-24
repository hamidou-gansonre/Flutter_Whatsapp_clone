
import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';
import 'package:whatsapp_app/features/call/domain/repositories/call_repository.dart';

class UpdateCallHistoryStatusUseCase {

  final CallRepository repository;

  const UpdateCallHistoryStatusUseCase({required this.repository});

  Future<void> call(CallEntity call) async {
    return await repository.updateCallHistoryStatus(call);
  }
}