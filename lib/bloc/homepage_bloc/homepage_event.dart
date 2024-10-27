part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();
}

final class SelectShiftHomepageEvent extends HomepageEvent {
  final String shift;
  const SelectShiftHomepageEvent({required this.shift});
  @override
  List<Object?> get props => [shift];
}

final class SelectMachineHomepageEvent extends HomepageEvent {
  final String shift;
  final String machineId;

  const SelectMachineHomepageEvent({required this.shift, required this.machineId});

  @override
  List<Object?> get props => [machineId];
}

final class SelectNeedleUsedHomepageEvent extends HomepageEvent {
  final String shift;
  final String needleUsedIn;
  final Machine machine;

  const SelectNeedleUsedHomepageEvent({required this.shift, required this.needleUsedIn, required this.machine});

  @override
  List<Object?> get props => [needleUsedIn, machine];
}

final class SelectNeedleNumberHomepageEvent extends HomepageEvent {
  final String shift;
  final Machine machine;
  final String needleUsedIn;
  final List<Needle> needles;
  final Needle needle;
  const SelectNeedleNumberHomepageEvent({required this.shift, required this.machine, required this.needleUsedIn, required this.needles, required this.needle});

  @override
  List<Object?> get props => [machine, needle];
}

final class SubmitButtonClickHomepageEvent extends HomepageEvent {
  final String shift;
  final Machine machine;
  final String needleUsedIn;
  final List<Needle> needles;
  final Needle needle;
  final int operatorId;
  final int changeNeedleNumber;
  final String changeReason;
  const SubmitButtonClickHomepageEvent({required this.shift, required this.machine, required this.needleUsedIn, required this.needles, required this.needle, required this.operatorId, required this.changeNeedleNumber, required this.changeReason});
  @override
  List<Object?> get props => [];
}