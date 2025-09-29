import 'package:dartz/dartz.dart';
import 'package:telephone_recharge_application/core/errors/failure.dart';
import 'package:telephone_recharge_application/core/usecase/usecase.dart';
import 'package:telephone_recharge_application/features/mode/domain/repository/mode_repository.dart';

class CheckCardModeUsecase implements Usecase<String, String> {
  final ModeRepository modeRepository;
  CheckCardModeUsecase({required this.modeRepository});
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await modeRepository.checkCardMode(signal: params);
  }
}
