import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>{

  DashboardCubit() : super(DashboardState.initial());


  void selectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void addLast(int index) {
    // emit(state.copyWith(navigationQueue: index));
  }

}