import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:needle_management/model/machine_model.dart';
import 'package:needle_management/model/needle_model.dart';
import 'package:needle_management/model/needle_transaction_model.dart';
import '../../database/online_database/firestore_repository.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<SelectShiftHomepageEvent>((event, emit) {
      emit(MachineLoadedHomepageState(shift: event.shift));
    });
    on<SelectMachineHomepageEvent>((event, emit) async {
      emit(MachineLoadingHomepageState());
      try {
        FirestoreRepository repository = FirestoreRepository();
        Machine machine = await repository.getMachineData(event.machineId);
        emit(MachineLoadedHomepageState(shift: event.shift,machine: machine));
      } catch(error) {
        emit(HomepageError(errorMessage: error.toString()));
      }
    });

    on<SelectNeedleUsedHomepageEvent>((event, emit) async {
      emit(NeedleNumberLoadingHomepageState());
      try {
        FirestoreRepository repository = FirestoreRepository();
        List<Needle> needles = await repository.getNeedleData(event.machine, event.needleUsedIn);
        emit(MachineLoadedHomepageState(shift: event.shift, machine: event.machine, needleUsedIn: event.needleUsedIn, needles: needles));
      } catch(error) {
        emit(HomepageError(errorMessage: error.toString()));
      }
    });

    on<SelectNeedleNumberHomepageEvent>((event, emit) {
      emit(MachineLoadedHomepageState(shift: event.shift, machine: event.machine, needleUsedIn: event.needleUsedIn, needles: event.needles, needle: event.needle));
    });

    on<SubmitButtonClickHomepageEvent>((event, emit) async {
      emit(HomepageLoading());
      FirestoreRepository repository = FirestoreRepository();
      int shift = 0;
      if(event.shift == 'A') {
        shift = 1;
      } else if(event.shift == 'B') {
        shift = 2;
      } else if(event.shift == 'C') {
        shift = 3;
      }
      String transactionId = '${event.machine.machineId}_${DateTime.now()}';
      NeedleTransaction transaction = NeedleTransaction(transactionId: transactionId, needleNumber: event.needle.needleNumber, transactionType: "use", quantity: event.changeNeedleNumber, transactionDate: DateTime.now(), shift: shift, submittedBy: event.operatorId, reason: event.changeReason, machineId: event.machine.machineId);
      await repository.uploadTransaction(transaction);
      emit(HomepageInitial());
    });
  }
}
