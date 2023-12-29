// AddSlotPage.dart
import 'package:flutter/material.dart';

class AddSlotPage extends StatelessWidget {
  const AddSlotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Slot Booking'),
      ),
      body: Center(
        child: Text('This is the page to add slot booking to available services.'),
      ),
    );
  }
}
