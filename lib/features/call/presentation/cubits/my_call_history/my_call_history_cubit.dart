import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_app/features/call/domain/entities/call_entities.dart';
import 'package:whatsapp_app/features/call/domain/use_cases/get_my_call_history_usecase.dart';

part 'my_call_history_state.dart';

class MyCallHistoryCubit extends Cubit<MyCallHistoryState> {
  final GetMyCallHistoryUseCase getMyCallHistoryUseCase;
  MyCallHistoryCubit({
    required this.getMyCallHistoryUseCase
  }) : super(MyCallHistoryInitial());

  Future<void> getMyCallHistory({required String uid}) async {
    emit(MyCallHistoryLoading());
    try {

      final streamResponse = getMyCallHistoryUseCase.call(uid);
      streamResponse.listen((myCallHistory) {
        emit(MyCallHistoryLoaded(myCallHistory: myCallHistory));
      });
    } on SocketException {
      emit(MyCallHistoryFailure());
    } catch(_) {
      emit(MyCallHistoryFailure());
    }
  }
}
