part of 'get_recharge_history_cubit.dart';

@immutable
sealed class GetRechargeHistoryState {}

final class GetRechargeHistoryInitial extends GetRechargeHistoryState {}

final class GetRechargeHistorySuccessState extends GetRechargeHistoryState {
  final List<RechargeHistoryEntity> rechargeHistory;
  GetRechargeHistorySuccessState({required this.rechargeHistory});
}

final class GetRechargeHistoryFailureState extends GetRechargeHistoryState{
  final String message;
  GetRechargeHistoryFailureState({required this.message});
}

final class GetRechargeHistoryLoadingState extends GetRechargeHistoryState{}
