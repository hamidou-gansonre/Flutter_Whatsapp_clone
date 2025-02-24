import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';
import 'package:whatsapp_app/features/call/domain/repositories/call_repository.dart';

class GetMyCallHistoryUseCase {

  final CallRepository repository;

  const GetMyCallHistoryUseCase({required this.repository});

  Stream<List<CallEntity>> call(String uid)  {
    return repository.getMyCallHistory(uid);
  }
}