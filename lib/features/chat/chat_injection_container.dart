
import 'package:whatsapp_app/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:whatsapp_app/features/chat/data/remote/chat_remote_data_source_impl.dart';
import 'package:whatsapp_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:whatsapp_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/delete_message_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/delete_my_chat_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/get_my_chat_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/seen_message_update_usecase.dart';
import 'package:whatsapp_app/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:whatsapp_app/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp_app/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp_app/main_injection_container.dart';

Future<void> chatInjectionContainer() async {
//* CUBITS INJECTION
  sl.registerFactory<ChatCubit>(() => ChatCubit(
    getMyChatUseCase: sl.call(),
    deleteMyChatUseCase: sl.call(),
  ));

  sl.registerFactory<MessageCubit>(() => MessageCubit(
    getMessagesUseCase: sl.call(),
    deleteMessageUseCase: sl.call(),
    sendMessageUseCase: sl.call(),
    seenMessageUpdateUseCase: sl.call(),
  ));


  //* CUBITS INJECTION END

  //* USE CASES INJECTION START
  sl.registerLazySingleton<DeleteMessageUseCase>(
          () => DeleteMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteMyChatUseCase>(
          () => DeleteMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMessagesUseCase>(
          () => GetMessagesUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMyChatUseCase>(
          () => GetMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<SendMessageUseCase>(
          () => SendMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<SeenMessageUpdateUseCase>(
          () => SeenMessageUpdateUseCase(repository: sl.call()));

  //* REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ChatRepository>(
          () => ChatRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(
    fireStore: sl.call(),
  ));


}


