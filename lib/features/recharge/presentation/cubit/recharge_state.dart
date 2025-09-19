part of 'recharge_cubit.dart';

@immutable
sealed class RechargeState {}

final class RechargeInitial extends RechargeState {}

final class RechargeSuccessState extends RechargeState {
  final String message;
  RechargeSuccessState({required this.message});
}

final class RechargeFailureState extends RechargeState {
  final String message;
  RechargeFailureState({required this.message});
}

final class RechargeLoadingState extends RechargeState {}
