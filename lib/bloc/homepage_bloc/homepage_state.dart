part of 'homepage_bloc.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();
}

final class HomepageInitial extends HomepageState {
  @override
  List<Object> get props => [];
}

final class HomepageLoading extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class HomepageError extends HomepageState {
  final String errorMessage;
  const HomepageError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class MachineLoadingHomepageState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class MachineLoadedHomepageState extends HomepageState {
  final String shift;
  final Machine? machine;
  final String? needleUsedIn;
  final List<Needle>? needles;
  final Needle? needle;
  const MachineLoadedHomepageState({required this.shift, this.machine, this.needleUsedIn, this.needles, this.needle});
  @override
  List<Object?> get props => [machine, needleUsedIn, needles, needle];
}

final class NeedleNumberLoadingHomepageState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class NeedleNumberLoadedHomepageState extends HomepageState {
  final List<String> needleNumberList;

  const NeedleNumberLoadedHomepageState({required this.needleNumberList});

  @override
  List<Object?> get props => [needleNumberList];
}