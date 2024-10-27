import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:needle_management/widget/machine_dropdown_button.dart';
import 'package:needle_management/widget/needle_number_dropdown_button.dart';
import 'package:needle_management/widget/needle_used_dropdown_button.dart';
import 'package:needle_management/widget/number_of_needles_field.dart';
import 'package:needle_management/widget/operator_id_field.dart';
import 'package:needle_management/widget/reason_field.dart';
import 'package:needle_management/widget/shift_dropdown_button.dart';
import 'package:needle_management/widget/submit_button.dart';

class MobileHomepage extends StatefulWidget {

  MobileHomepage({super.key});

  @override
  State<MobileHomepage> createState() => _MobileHomepageState();
}

class _MobileHomepageState extends State<MobileHomepage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _operatorIdController = TextEditingController();

  final TextEditingController _numOfNeedlesController = TextEditingController();

  final TextEditingController _reasonController = TextEditingController();

  // ValueNotifier to manage the submit button state
  final ValueNotifier<bool> _isFormValid = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    // Adding listeners to controllers to check validation on each input change
    _operatorIdController.addListener(_validateForm);
    _numOfNeedlesController.addListener(_validateForm);
    _reasonController.addListener(_validateForm);

    return Container(
      color: Colors.teal[50],
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is HomepageInitial) {
            return const SingleChildScrollView(
              child: Column(
                children: [
                  ShiftDropdownButton(),
                ],
              ),
            );
          } else if (state is MachineLoadedHomepageState) {
            bool isNeedleNumberLoaded = state.needles != null;
            bool isNeedleSelected = state.needle != null;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ShiftDropdownButton(state: state,),
                  MachineDropdownButton(state: state,),
                  const SizedBox(height: 20,),
                  NeedleUsedDropdownButton(state: state,),
                  const SizedBox(height: 20,),
                  NeedleNumberDropdownButton(state: state,),
                  const SizedBox(height: 20,),
                  isNeedleNumberLoaded && isNeedleSelected ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        OperatorIdField(_operatorIdController),
                        const SizedBox(height: 20,),
                        NumberOfNeedlesField(_numOfNeedlesController),
                        const SizedBox(height: 20,),
                        ReasonField(_reasonController),
                        const SizedBox(height: 20,),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isFormValid,
                          builder: (context, isFormValid, child) {
                            return SubmitButton(context, state, _formKey, isFormValid, _operatorIdController, _numOfNeedlesController, _reasonController);
                          },
                        ),
                      ],
                    ),
                  ) : Container(),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  // Helper function to validate the form
  void _validateForm() {
    _isFormValid.value = _formKey.currentState?.validate() ?? false;
  }
}