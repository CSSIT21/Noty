import 'package:flutter/material.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  final bool isChecked;
  final String reminderId;
  const CheckBox({Key? key, required this.isChecked, required this.reminderId})
      : super(key: key);

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  late bool isChecked = widget.isChecked;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.black,
      value: isChecked,
      shape: const CircleBorder(),
      onChanged: (bool? value) {
        setState(() {
          isChecked = !isChecked;
        });
        context
            .read<ReminderProvider>()
            .updateReminderProgress(widget.reminderId, isChecked, context);
      },
    );
  }
}
