import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:needle_management/model/needle_model.dart';
import 'package:needle_management/widget/disable_dropdown_button.dart';

class NeedleNumberDropdownButton extends StatefulWidget {
  final MachineLoadedHomepageState state;
  const NeedleNumberDropdownButton({required this.state, super.key});

  @override
  State<NeedleNumberDropdownButton> createState() => _NeedleNumberDropdownButtonState();
}

class _NeedleNumberDropdownButtonState extends State<NeedleNumberDropdownButton> {

  String dropdownValue = 'Select Needle Number';

  List<DropdownMenuItem<String>> menuItem(MachineLoadedHomepageState state) {
    List<DropdownMenuItem<String>> items = [
      const DropdownMenuItem(value: "Select Needle Number", child: Text("Select Needle Number"),),
    ];
    final needles = state.needles;
    if (needles != null) {
      for (Needle needle in needles) {
        items.add(DropdownMenuItem<String>(value: needle.needleNumber, child: Text(needle.needleNumber)));
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return widget.state.needleUsedIn != null ? DropdownButton<String>(
      value: widget.state.needle == null ? dropdownValue : widget.state.needle?.needleNumber,
      icon: Row(
        children: [
          const SizedBox(width: 5.0,),
          Image.asset("assets/needle_logo.png", height: 25,),
        ],
      ),
      items: menuItem(widget.state),
      onChanged: (String? newValue) {
        setState(() {
          if(newValue != "Select Needle Number") {
            Needle? needle = widget.state.needles?.firstWhere((needle) => needle.needleNumber == newValue);
            context.read<HomepageBloc>().add(SelectNeedleNumberHomepageEvent(shift: widget.state.shift, machine: widget.state.machine!, needleUsedIn: widget.state.needleUsedIn!, needles: widget.state.needles!, needle: needle!));
          }
          dropdownValue = newValue!;
        });
        },
      dropdownColor: Colors.teal[100],
    ) : DisableDropdownButton(context, dropdownValue);
  }
}
