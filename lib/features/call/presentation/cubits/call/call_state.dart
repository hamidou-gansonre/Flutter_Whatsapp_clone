part of 'call_cubit.dart';

sealed class CallState extends Equatable {
  const CallState();
}

final class CallInitial extends CallState {
  @override
  List<Object> get props => [];
}

class IsCalling extends CallState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CallDialed extends CallState {
  final CallEntity userCall;
  CallDialed({required this.userCall});
  @override
  List<Object> get props => [userCall];
}

class CallFailed extends CallState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
