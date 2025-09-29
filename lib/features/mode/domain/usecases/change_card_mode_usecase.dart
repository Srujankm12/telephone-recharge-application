import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/mode/domain/repository/mode_repository.dart';

class ChangeCardModeUsecase implements Usecase<String, ChangeCardModeParams> {
  final ModeRepository modeRepository;
  ChangeCardModeUsecase({required this.modeRepository});
  @override
  Future<Either<Failure, String>> call(ChangeCardModeParams params) async {
    return await modeRepository.changeCardMode(
      signal: params.signal,
      mode: params.mode,
    );
  }
}

class ChangeCardModeParams {
  final String signal;
  final String mode;
  ChangeCardModeParams({required this.signal, required this.mode});
}
