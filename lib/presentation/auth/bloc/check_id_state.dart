part of 'check_id_cubit.dart';

@immutable
sealed class CheckIdState {


  CheckIdState();
}

final class CheckIdInitial extends CheckIdState {
  CheckIdInitial() : super();
}

final class CheckIdLoading extends CheckIdState {
  CheckIdLoading() : super();
}

final class CheckIdLoaded extends CheckIdState {
  final CheckIdModel checkIdModel;

  CheckIdLoaded(this.checkIdModel)
  ;
}

final class CheckIdFailure extends CheckIdState {
  final String message;

  CheckIdFailure(this.message) ;
}
