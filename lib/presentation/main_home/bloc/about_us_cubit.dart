import 'package:bloc/bloc.dart';
import 'package:medapp/domain/app/usecase/get_about_us_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/app/model/about_us_model.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());
  Future<void> getAboutUs() async {
    emit(AboutUsLoadingState());
    var result = await getIt<GetAboutUsUsecase>().call();
    result.fold(
      (failure) {
        emit(AboutUsFailureState());
      },
      (aboutUs) {
        emit(AboutUsLoadedState(aboutUs));
      },
    );
  }
}
