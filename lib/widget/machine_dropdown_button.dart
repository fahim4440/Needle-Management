import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:needle_management/database/local_database/machine_strings.dart';


class MachineDropdownButton extends StatefulWidget {
  final MachineLoadedHomepageState state;
  const MachineDropdownButton({required this.state, super.key});

  @override
  State<MachineDropdownButton> createState() => _MachineDropdownButtonState();
}

class _MachineDropdownButtonState extends State<MachineDropdownButton> {

  String dropdownValue = 'Select Machine';
  List<String> machineNames = ['Select Machine'] + MachineString().machineNames;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Row(
        children: [
          const SizedBox(width: 5.0,),
          Image.asset("assets/knitting_machine.png", height: 25,),
        ],
      ),
      value: widget.state.machine == null ? dropdownValue : widget.state.machine!.machineId,
      items: machineNames.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.black),),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (widget.state.machine == null) {
            if(newValue != "Select Machine") {
              context.read<HomepageBloc>().add(SelectMachineHomepageEvent(shift: widget.state.shift, machineId: newValue!));
            }
          } else {
            if(newValue != "Select Machine" && newValue != widget.state.machine!.machineId) {
              context.read<HomepageBloc>().add(SelectMachineHomepageEvent(shift: widget.state.shift, machineId: newValue!));
            }
          }
          dropdownValue = newValue!;
        });
      },
      dropdownColor: Colors.teal[100],
    );
  }
}
