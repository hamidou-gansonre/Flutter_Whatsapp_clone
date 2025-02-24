import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';
import 'package:whatsapp_app/features/call/domain/repositories/call_repository.dart';

class MakeCallUseCase {

  final CallRepository repository;

  const MakeCallUseCase({required this.repository});

  Future<void> call(CallEntity call) async {
    return await repository.makeCall(call);
  }
}