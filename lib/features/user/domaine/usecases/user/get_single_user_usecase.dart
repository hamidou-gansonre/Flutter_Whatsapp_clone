import 'package:whatsapp_app/features/user/domaine/entities/user_entity.dart';
import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class GetSingleUserUseCase{
  final UserRepository repository ;
  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}