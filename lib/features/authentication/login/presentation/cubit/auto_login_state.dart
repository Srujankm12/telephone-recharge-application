part of 'auto_login_cubit.dart';

@immutable
sealed class AutoLoginState {}

final class AutoLoginInitial extends AutoLoginState {}

final class AutoLoginSuccessState extends AutoLoginState{}

final class AutoLoginFailureState extends AutoLoginState{
  final String message;
  AutoLoginFailureState({required this.message});
}

final class AutoLoginLoadingState extends AutoLoginState{}
