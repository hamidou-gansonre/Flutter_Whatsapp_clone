import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class SignOutUseCase{
  final UserRepository repository;
  SignOutUseCase({required this.repository});

  Future<void> call() async{
    return  repository.signOut();
  }

}