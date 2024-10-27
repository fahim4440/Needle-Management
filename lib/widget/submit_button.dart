import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/homepage_bloc/homepage_bloc.dart';

MaterialButton SubmitButton(BuildContext context, MachineLoadedHomepageState state, GlobalKey<FormState> formKey, bool isFormValid, TextEditingController operatorIdController, TextEditingController numOfNeedlesController, TextEditingController reasonController) {
  return MaterialButton(
    onPressed: isFormValid ? () {
      if (formKey.currentState!.validate()) {
        int operatorId = int.parse(operatorIdController.text);
        int numOfNeedles = int.parse(numOfNeedlesController.text);
        String reason = reasonController.text;

        // Clear the text fields
        operatorIdController.clear();
        numOfNeedlesController.clear();
        reasonController.clear();
        context.read<HomepageBloc>().add(SubmitButtonClickHomepageEvent(shift: state.shift, machine: state.machine!, needleUsedIn: state.needleUsedIn!, needles: state.needles!, needle: state.needle!, operatorId: operatorId, changeNeedleNumber: numOfNeedles, changeReason: reason));
      }
    } : null,
    color: Colors.teal[200],
    disabledColor: Colors.grey,
    splashColor: Colors.teal[300],
    highlightColor: Colors.teal[300],
    focusColor: Colors.amber,
    child: const Text("Submit"),
  );
}