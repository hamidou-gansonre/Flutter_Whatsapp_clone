part of 'agora_cubit.dart';

sealed class AgoraState extends Equatable {
  const AgoraState();
}

final class AgoraInitial extends AgoraState {
  @override
  List<Object> get props => [];
}
