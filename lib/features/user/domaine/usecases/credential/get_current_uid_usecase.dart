import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class GetCurrentUidUseCase{
  final UserRepository repository;
  GetCurrentUidUseCase( {required this.repository});

  Future<String> call() async{
    return  repository.getCurrentUID();
  }

}