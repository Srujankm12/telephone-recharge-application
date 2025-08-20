import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'init_card_restricted_state.dart';

class InitCardRestrictedCubit extends Cubit<InitCardRestrictedState> {
  InitCardRestrictedCubit() : super(InitCardRestrictedInitial());
}
