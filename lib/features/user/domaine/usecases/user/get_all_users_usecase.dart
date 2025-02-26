import 'package:whatsapp_app/features/user/domaine/entities/user_entity.dart';
import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class GetAllUsersUseCase{
  final UserRepository repository ;
  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}