import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  GetBalanceCubit() : super(GetBalanceInitial());
}
