import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_card_mode_state.dart';

class ChangeCardModeCubit extends Cubit<ChangeCardModeState> {
  ChangeCardModeCubit() : super(ChangeCardModeInitial());
}
