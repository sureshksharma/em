part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  const factory HomeState.initial() = Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.loaded() = Loaded;
  const factory HomeState.deleted() = Deleted;
  const factory HomeState.restored() = Restored;
  const factory HomeState.errorRestore(String message) = RestoreError;
  const factory HomeState.error(String message) = Error;

  @override
  List<Object?> get props => [];
}

class Initial extends HomeState {
  const Initial();
}

class Loading extends HomeState {
  const Loading();
}

class Loaded extends HomeState {
  const Loaded();
}

class Deleted extends HomeState {
  const Deleted();
}

class Restored extends HomeState {
  const Restored();
}

class RestoreError extends HomeState {
  final String message;
  const RestoreError(this.message);

  @override
  List<Object?> get props => [message];
}

class Error extends HomeState {
  final String message;
  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
