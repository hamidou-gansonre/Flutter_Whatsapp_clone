import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class IsSignInUseCase{
  final UserRepository repository;
  IsSignInUseCase({required this.repository});

  Future<bool> call() async{
    return  repository.isSignIn();
  }

}