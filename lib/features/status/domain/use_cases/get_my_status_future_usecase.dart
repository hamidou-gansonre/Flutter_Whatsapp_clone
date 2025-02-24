import 'package:whatsapp_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_app/features/status/domain/repositories/status_repository.dart';
class GetMyStatusFutureUseCase {

  final StatusRepository repository;

  const GetMyStatusFutureUseCase({required this.repository});

  Future<List<StatusEntity>> call(String uid) async {
    return  repository.getMyStatusFuture(uid);
  }
}
