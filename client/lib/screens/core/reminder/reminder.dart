import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReminderFragment extends StatefulWidget {
  const ReminderFragment({Key? key}) : super(key: key);

  @override
  State<ReminderFragment> createState() => _ReminderFragmentState();
}

class _ReminderFragmentState extends State<ReminderFragment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: const Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Save',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: const ListTile(title: Text('Slide me')),
      ),
    );
  }
}
