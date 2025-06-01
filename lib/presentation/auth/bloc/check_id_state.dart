part of 'check_id_cubit.dart';

@immutable
sealed class CheckIdState {
  final bool isValid;

  CheckIdState(this.isValid);
}

final class CheckIdInitial extends CheckIdState {
  CheckIdInitial() : super(false);
}

final class CheckIdLoading extends CheckIdState {
  CheckIdLoading() : super(false);
}

final class CheckIdLoaded extends CheckIdState {
  final CheckIdModel checkIdModel;

  CheckIdLoaded(this.checkIdModel)
    : super((checkIdModel.signUpStatus == "yes"));
}

final class CheckIdFailure extends CheckIdState {
  final String message;

  CheckIdFailure(this.message) : super(false);
}
