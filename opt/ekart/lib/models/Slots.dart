import 'package:flutter/material.dart';
import 'bank.dart';

class ViewSlotsDialog extends StatelessWidget {
  final ServiceModel serviceModel;

  const ViewSlotsDialog(this.serviceModel, {Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Slots Management'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Available Slots:'),
            const SizedBox(height: 8.0),
            Column(
              children: serviceModel.availableSlots.map((slot) {
                return SlotRow(slotTime: slot);
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text('Unavailable Slots:'),
            const SizedBox(height: 8.0),
            Column(
              children: serviceModel.unavailableSlots.map((slot) {
                return SlotRow(slotTime: slot);
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class SlotButton extends StatelessWidget {
  final String slotTime;
  final bool isSelected;
  final VoidCallback onTap;

  const SlotButton({
    Key? key,
    required this.slotTime,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        color: isSelected ? Colors.orange : Colors.grey[300],
        child: Text(
          slotTime,
          style: TextStyle(color: isSelected ? Colors.black : null),
        ),
      ),
    );
  }
}

class SlotRow extends StatelessWidget {
  final String slotTime;

  const SlotRow({Key? key, required this.slotTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            color: Colors.grey[300],
            child: Text(slotTime),
          ),
        ),
      ],
    );
  }
}
// AddSlotDialog - To add new slots
// AddSlotDialog - To add new slots
class AddSlotDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const AddSlotDialog(this.serviceModel, {Key? key}) : super(key: key);

  @override
  _AddSlotDialogState createState() => _AddSlotDialogState();
}

class _AddSlotDialogState extends State<AddSlotDialog> {
  TextEditingController slotNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Slots'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Unavailable Slots:'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              child: Column(
                children: widget.serviceModel.unavailableSlots.map((slot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          slotNameController.text = slot;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellowAccent,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('New Slot:'),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: slotNameController,
              decoration: const InputDecoration(labelText: 'Slot Name'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newSlot = slotNameController.text;
            if (newSlot.isNotEmpty) {
              widget.serviceModel.addSlot(newSlot);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
// MakeSlotUnavailableDialog - To make slots unavailable
class MakeSlotUnavailableDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const MakeSlotUnavailableDialog(this.serviceModel, {Key? key}) : super(key: key);

  @override
  _MakeSlotUnavailableDialogState createState() => _MakeSlotUnavailableDialogState();
}

class _MakeSlotUnavailableDialogState extends State<MakeSlotUnavailableDialog> {
  List<String> selectedSlots = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Slot Unavailable'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Available Slots:'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              child: Column(
                children: widget.serviceModel.availableSlots.map((slot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedSlots.contains(slot)) {
                            selectedSlots.remove(slot);
                          } else {
                            selectedSlots.add(slot);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          selectedSlots.contains(slot)
                              ? Colors.orange
                              : Colors.yellowAccent,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            for (String slot in selectedSlots) {
              widget.serviceModel.makeSlotUnavailable(slot);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// RemoveSlotDialog - To remove slots
class RemoveSlotDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const RemoveSlotDialog(this.serviceModel, {Key? key}) : super(key: key);

  @override
  _RemoveSlotDialogState createState() => _RemoveSlotDialogState();
}

class _RemoveSlotDialogState extends State<RemoveSlotDialog> {
  List<String> selectedSlots = [];
  String selectedList = 'Available'; // Default selection

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Slot'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select the slot list:'),
            const SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedList,
              items: ['Available', 'Unavailable'].map((list) {
                return DropdownMenuItem(
                  value: list,
                  child: Text(list),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedList = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (selectedList == 'Available')
              const Text('Available Slots:')
            else
              const Text('Unavailable Slots:'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              child: Column(
                children: (selectedList == 'Available'
                    ? widget.serviceModel.availableSlots
                    : widget.serviceModel.unavailableSlots)
                    .map((slot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedSlots.contains(slot)) {
                            selectedSlots.remove(slot);
                          } else {
                            selectedSlots.add(slot);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          selectedSlots.contains(slot)
                              ? Colors.orange
                              : Colors.yellowAccent,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            for (String slot in selectedSlots) {
              widget.serviceModel.RemoveSlot(slot);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
