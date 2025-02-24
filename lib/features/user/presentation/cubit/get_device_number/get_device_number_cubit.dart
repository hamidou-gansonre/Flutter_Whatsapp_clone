import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_app/features/user/domaine/entities/contact_entity.dart';
import 'package:whatsapp_app/features/user/domaine/usecases/user/get_device_number_usecase.dart';

part 'get_device_number_state.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  GetDeviceNumberUseCase getDeviceNumberUseCase;
  GetDeviceNumberCubit({required this.getDeviceNumberUseCase}) : super(GetDeviceNumberInitial());

  Future<void> getDeviceNumber() async {
    try{
      final contactNumber = await getDeviceNumberUseCase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumber));
    } catch(_){
      emit(GetDeviceNumberFailure());
    }
  }
}
