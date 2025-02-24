import 'package:whatsapp_app/features/user/domaine/entities/contact_entity.dart';
import 'package:whatsapp_app/features/user/domaine/repository/user_repository.dart';

class GetDeviceNumberUseCase{
  final UserRepository repository ;
  GetDeviceNumberUseCase( {required this.repository});

  Future<List<ContactEntity>> call() async{
    return repository.getDeviceNumber();
  }
}