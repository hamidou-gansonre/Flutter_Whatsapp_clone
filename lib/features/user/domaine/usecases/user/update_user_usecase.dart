import 'package:whatsapp_app/features/user/domaine/entities/user_entity.dart';
import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class UpdateUserUseCase{
  final UserRepository repository ;
  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async{
    return repository.updateUser(user);
  }
}