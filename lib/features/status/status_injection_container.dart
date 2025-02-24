
import 'package:whatsapp_app/features/status/data/remote/data_sources/status_remote_data_source.dart';
import 'package:whatsapp_app/features/status/data/remote/data_sources/status_remote_data_source_impl.dart';
import 'package:whatsapp_app/features/status/data/repositories/status_repository_impl.dart';
import 'package:whatsapp_app/features/status/domain/repositories/status_repository.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/create_status_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/delete_status_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/get_my_status_future_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/get_my_status_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/get_statuses_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/seen_status_update_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/update_only_image_status_usecase.dart';
import 'package:whatsapp_app/features/status/domain/use_cases/update_status_usecase.dart';
import 'package:whatsapp_app/features/status/presentation/cubit/get_my_status/get_my_status_cubit.dart';
import 'package:whatsapp_app/features/status/presentation/cubit/status/status_cubit.dart';

import '../../main_injection_container.dart';

Future<void> statusInjectionContainer() async {


  // * CUBITS INJECTION

  sl.registerFactory<StatusCubit>(() => StatusCubit(
      createStatusUseCase: sl.call(),
      deleteStatusUseCase: sl.call(),
      getStatusesUseCase: sl.call(),
      updateStatusUseCase: sl.call(),
      updateOnlyImageStatusUseCase: sl.call(),
      seenStatusUpdateUseCase: sl.call()
  ));

  sl.registerFactory<GetMyStatusCubit>(() => GetMyStatusCubit(
    getMyStatusUseCase: sl.call(),
  ));

  // * USE CASES INJECTION

  sl.registerLazySingleton<GetMyStatusUseCase>(
          () => GetMyStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateOnlyImageStatusUseCase>(
          () => UpdateOnlyImageStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMyStatusFutureUseCase>(
          () => GetMyStatusFutureUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetStatusesUseCase>(
          () => GetStatusesUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteStatusUseCase>(
          () => DeleteStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateStatusUseCase>(
          () => UpdateStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<CreateStatusUseCase>(
          () => CreateStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<SeenStatusUpdateUseCase>(
          () => SeenStatusUpdateUseCase(repository: sl.call()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<StatusRepository>(
          () => StatusRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<StatusRemoteDataSource>(() => StatusRemoteDataSourceImpl(
    fireStore: sl.call(),
  ));
}