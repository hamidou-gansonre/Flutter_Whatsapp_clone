import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';
import 'package:whatsapp_app/features/call/domain/repositories/call_repository.dart';

class EndCallUseCase {
  final CallRepository repository;

 const  EndCallUseCase({required this.repository});

 Future<void> call(CallEntity call) async {
   return await repository.endCall( call);
 }

}