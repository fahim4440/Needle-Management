import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';

class ShiftDropdownButton extends StatefulWidget {
  final MachineLoadedHomepageState? state;
  const ShiftDropdownButton({this.state, super.key});

  @override
  State<ShiftDropdownButton> createState() => _ShiftDropdownButtonState();
}

class _ShiftDropdownButtonState extends State<ShiftDropdownButton> {

  String dropdownValue = 'Select Shift';
  List<String> shiftName = ['Select Shift', 'A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Row(
        children: [
          SizedBox(width: 5.0,),
          Icon(Icons.screen_rotation_alt_sharp, color: Colors.black,),
        ],
      ),
      value: widget.state == null ? dropdownValue : widget.state!.shift,
      items: shiftName.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text("Shift: $item", style: const TextStyle(color: Colors.black),),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (widget.state == null) {
            if(newValue != "Select Shift") {
              context.read<HomepageBloc>().add(SelectShiftHomepageEvent(shift: newValue!));
            }
          } else {
            if(newValue != "Select Machine" && newValue != widget.state!.machine!.machineId) {
              context.read<HomepageBloc>().add(SelectShiftHomepageEvent(shift: newValue!));
            }
          }
          dropdownValue = newValue!;
        });
      },
      dropdownColor: Colors.teal[100],
    );
  }
}
