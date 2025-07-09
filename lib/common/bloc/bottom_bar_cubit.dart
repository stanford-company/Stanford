// bottom_bar_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarCubit extends Cubit<bool> {
  BottomBarCubit() : super(true); // true = visible

  void show() => emit(true);

  void hide() => emit(false);
}