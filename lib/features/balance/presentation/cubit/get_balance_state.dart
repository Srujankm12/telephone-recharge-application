part of 'get_balance_cubit.dart';

@immutable
sealed class GetBalanceState {}

final class GetBalanceInitial extends GetBalanceState {}

final class GetBalanceSuccessState extends GetBalanceState{
  final String balance;
  GetBalanceSuccessState({required this.balance});
}

final class GetBalanceFailureState extends GetBalanceState{}

final class GetBalanceLoadingState extends GetBalanceState{}