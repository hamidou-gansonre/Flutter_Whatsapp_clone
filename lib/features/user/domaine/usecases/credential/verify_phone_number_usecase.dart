import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class VerifyPhoneNumberUseCase{
  final UserRepository repository;
  VerifyPhoneNumberUseCase({required this.repository});

  Future<void> call(String phoneNumber) async{
    return  repository.verifyPhoneNumber(phoneNumber);
  }

}