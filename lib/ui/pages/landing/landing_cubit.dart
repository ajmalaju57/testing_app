import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit(selectedIndex) : super(LandingInitial(currentIndex: selectedIndex));

  final currentIndex = 0;

  onBottomCLicked(int index) {
    emit(LandingInitial(currentIndex: index));
  }
}
