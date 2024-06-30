sealed class Event {}

class InitialState extends Event {}

class OnlyPhotoState extends Event {}

class LoadingState extends Event {}

class SuccessState extends Event {
  final String result;
  SuccessState(this.result);
}

class ErrorState extends Event {
  final String error;
  ErrorState(this.error);
}