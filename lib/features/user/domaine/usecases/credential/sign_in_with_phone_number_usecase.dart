import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class SignInWithPhoneNumberUseCase{
  final UserRepository repository;
  SignInWithPhoneNumberUseCase({required this.repository});

  Future<void> call(String smsPinCode) async{
    return  repository.signInWithPhoneNumber(smsPinCode);
  }

}