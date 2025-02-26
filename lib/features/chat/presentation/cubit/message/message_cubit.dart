import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_app/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_app/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_app/features/chat/domain/entities/message_replay_entity.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/delete_message_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/seen_message_update_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/send_message_usecase.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final DeleteMessageUseCase deleteMessageUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SeenMessageUpdateUseCase seenMessageUpdateUseCase;
  MessageCubit(
      {required this.deleteMessageUseCase,
      required this.sendMessageUseCase,
      required this.getMessagesUseCase,
      required this.seenMessageUpdateUseCase})
      : super(MessageInitial());

  Future<void> getMessages({required MessageEntity message}) async {
    try {
      emit(MessageLoading());

      final streamResponse = getMessagesUseCase.call(message);
      streamResponse.listen((messages) {
        emit(MessageLoaded(messages: messages));
      });
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> deleteMessage({required MessageEntity message}) async {
    try {
      await deleteMessageUseCase.call(message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> sendMessage(
      {required ChatEntity chat, required MessageEntity message}) async {
    try {
      await sendMessageUseCase.call(chat, message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  Future<void> seenMessage(
      {required MessageEntity message}) async {
    try {
      await seenMessageUpdateUseCase.call( message);
    } on SocketException {
      emit(MessageFailure());
    } catch (_) {
      emit(MessageFailure());
    }
  }

  MessageReplayEntity messageReplay = MessageReplayEntity();
  MessageReplayEntity get getMessageReplay => MessageReplayEntity();

  set setMessageReplay(MessageReplayEntity messageReplay) {
    this.messageReplay = messageReplay;
  }
}
