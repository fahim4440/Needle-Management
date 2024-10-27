import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:needle_management/widget/disable_dropdown_button.dart';

class NeedleUsedDropdownButton extends StatefulWidget {
  final MachineLoadedHomepageState state;
  const NeedleUsedDropdownButton({required this.state, super.key});

  @override
  State<NeedleUsedDropdownButton> createState() => _NeedleUsedDropdownButtonState();
}

class _NeedleUsedDropdownButtonState extends State<NeedleUsedDropdownButton> {

  String dropdownValue = 'Select Needle Type';

  List<DropdownMenuItem<String>> menuItem(String machineType) {
    if(machineType.length >= 13) {
      if (machineType.substring(0, 13) == "Single Jersey") {
        return [
          const DropdownMenuItem(value: "Select Needle Type", child: Text("Select Needle Type"),),
          const DropdownMenuItem(value: "cylinder", child: Text("Cylinder"),),
          const DropdownMenuItem(value: "sinker", child: Text("Sinker"),),
        ];
      } else if (machineType.substring(0, 13) == "Double Jersey") {
        return [
          const DropdownMenuItem(value: "Select Needle Type", child: Text("Select Needle Type"),),
          const DropdownMenuItem(value: "cylinder", child: Text("Cylinder"),),
          const DropdownMenuItem(value: "dial", child: Text("Dial"),),
        ];
      }
    } else if(machineType == "Fleece") {
      return [
        const DropdownMenuItem(value: "Select Needle Type", child: Text("Select Needle Type"),),
        const DropdownMenuItem(value: "cylinder", child: Text("Cylinder"),),
        const DropdownMenuItem(value: "sinker", child: Text("sinker"),),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.state.machine != null ? DropdownButton<String>(
      value: widget.state.needleUsedIn ?? dropdownValue,
      icon: Image.asset("assets/knitting_machine.png", height: 25,),
      items: menuItem(widget.state.machine!.machineType),
      onChanged: (String? newValue) {
        setState(() {
          if(newValue != "Select Needle Type") {
            context.read<HomepageBloc>().add(SelectNeedleUsedHomepageEvent(shift: widget.state.shift, needleUsedIn: newValue!, machine: widget.state.machine!));
          }
          dropdownValue = newValue!;
        });
      },
      dropdownColor: Colors.teal[100],
    ) : DisableDropdownButton(context, dropdownValue);
  }
}
