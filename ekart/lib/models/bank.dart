import 'dart:math';
import 'Slots.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Bank Employee App',
      debugShowCheckedModeBanner: false,
      home: BankEmployeeScreen(),
    ),
  );
}

class ServiceModel extends ChangeNotifier {
  List<String> availableServices = ['Basic Money Transactions','Account Services','Card Services','Cheque book','FASTAG','Housing Loan','Education Loan','Vehicle Loan','Gold Loan','MSME Loan','Employees Provident fund (EPF)', 'Kisan Vikas Patra (KVP)', 'Sukanya Samriddhi Yojana','Insurance Services','Investment','MUTUAL FUNDS'];
  List<String> unavailableServices = ['Ekyc', 'Linking Aadhar with PAN','NRI Consultancy Services'];
  List<String> displayedServices = [];

  bool get isLoggedIn => _isLoggedIn;
  bool _isLoggedIn = false; // Initialize it to false

  // Slots related variables
  List<String> allSlots = [
    '10:00 to 10:15', '10:15 to 10:30', '10:30 to 10:45', '10:45 to 11:00',
    '11:00 to 11:15', '11:15 to 11:30', '11:30 to 11:45', '11:45 to 12:00',
    '12:00 to 12:15', '12:15 to 12:30', '12:30 to 12:45', '12:45 to 1:00',
    // No slots from 1:00 to 2:00
    '2:00 to 2:15', '2:15 to 2:30', '2:30 to 2:45', '2:45 to 3:00', '3:00 to 3:15',
    '3:15 to 3:30', '3:30 to 3:45', '3:45 to 4:00', '4:00 to 4:15', '4:15 to 4:30',
  ];

  List<String> unavailableSlots = [];
  List<String> availableSlots = [];

  void initializeSlots() {
    availableSlots = List.from(allSlots);
    // Let's randomly select some slots as unavailable initially
    final random = Random();
    final numberOfUnavailableSlots = random.nextInt(5) + 1; // Random number between 1 and 5
    for (int i = 0; i < numberOfUnavailableSlots; i++) {
      final randomIndex = random.nextInt(availableSlots.length);
      final unavailableSlot = availableSlots.removeAt(randomIndex);
      unavailableSlots.add(unavailableSlot);
    }
    notifyListeners();
  }
  // Add a method to get available slots for a given service
  List<String> getAvailableSlotsForService(String serviceName) {
    // Assuming all slots are initially available
    List<String> allSlots = [
      '10:00 to 10:15', '10:15 to 10:30', '10:30 to 10:45', '10:45 to 11:00',
      // ... (other slots)
    ];

    // Retrieve unavailable slots for the given service
    List<String> unavailableSlots = getUnavailableSlotsForService(serviceName);

    // Filter available slots
    List<String> availableSlots = allSlots.where((slot) => !unavailableSlots.contains(slot)).toList();

    return availableSlots;
  }

  // Add a method to get unavailable slots for a given service
  List<String> getUnavailableSlotsForService(String serviceName) {
    // Retrieve the unavailable slots for the given service from your data
    // You might have a data structure that stores this information
    // For now, we'll return an empty list
    return [];
  }
  // Add a method for viewing slots
  void viewSlots() {
    // Implement logic for viewing slots
  }

  // Add a method for adding new slots
  void addSlot(String newSlot) {
    if (!allSlots.contains(newSlot)) {
      allSlots.add(newSlot);
      availableSlots.add(newSlot);
      notifyListeners();
    }
  }

  // Add a method for making a slot unavailable
  void makeSlotUnavailable(String slot) {
    if (availableSlots.contains(slot)) {
      availableSlots.remove(slot);
      unavailableSlots.add(slot);
      notifyListeners();
    }
  }

  // Add a method for removing a slot
  void RemoveSlot(String slot) {
    if (allSlots.contains(slot)) {
      allSlots.remove(slot);
      availableSlots.remove(slot);
      unavailableSlots.remove(slot);
      notifyListeners();
    }
  }


  // Add a method to update the searchResult
  void updateSearchResult(String result) {

  }

  // Add a method for login
  void login() {
    // Your login logic here
    // After successful login, set _isLoggedIn to true
    _isLoggedIn = true;
    notifyListeners(); // Notify listeners that the state has changed
  }





  void addAvailableService(String serviceName) {
    if (!availableServices.contains(serviceName)) {
      availableServices.add(serviceName);
      unavailableServices.remove(serviceName);

      // Add the service to the displayed services list
      displayedServices.add(serviceName);
    
      notifyListeners();
    }
  }



  void makeServiceUnavailable(String serviceName) {
    if (availableServices.contains(serviceName)) {
      availableServices.remove(serviceName);
      unavailableServices.add(serviceName);
      notifyListeners();
    }
  }

  void removeService(String serviceName, String selectedList) {
    if (selectedList == 'Available') {
      if (availableServices.contains(serviceName)) {
        availableServices.remove(serviceName);
      }
    } else if (selectedList == 'Unavailable') {
      if (unavailableServices.contains(serviceName)) {
        unavailableServices.remove(serviceName);
      }
    }
    notifyListeners();
  }
}

class BankEmployeeScreen extends StatelessWidget {
  const BankEmployeeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var serviceModel = ServiceModel();
    serviceModel.displayedServices = List.from(serviceModel.availableServices);
    serviceModel.initializeSlots(); // Initialize slots

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Employee Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Service Management Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Service Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ViewServicesDialog(serviceModel),
                );
              },
              child: const Text('View Services'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MakeServiceAvailableDialog(serviceModel),
                );
              },
              child: const Text('Add Available Service'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MakeServiceUnavailableDialog(serviceModel),
                );
              },
              child: const Text('Make Service Unavailable'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RemoveServiceDialog(serviceModel),
                );
              },
              child: const Text('Remove Service'),
            ),

            // Slot Management Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Slot Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ViewSlotsDialog(serviceModel),
                );
              },
              child: const Text('View Slots'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddSlotDialog(serviceModel),
                );
              },
              child: const Text('Add Slot'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MakeSlotUnavailableDialog(serviceModel),
                );
              },
              child: const Text('Make Slot Unavailable'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RemoveSlotDialog(serviceModel),
                );
              },
              child: const Text('Remove Slot'),
            ),

            // Booked Slots Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Booked Slots',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Add your UI for displaying booked slots here
          ],
        ),
      ),
    );
  }
}

class ViewServicesDialog extends StatelessWidget {
  final ServiceModel serviceModel;

  const ViewServicesDialog(this.serviceModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Services'),
      content: SingleChildScrollView(  // Added SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Available Services:'),
            const SizedBox(height: 8.0),
            Column(
              children: serviceModel.availableServices.map((service) {
                return ServiceRow(serviceName: service);
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text('Unavailable Services:'),
            const SizedBox(height: 8.0),
            Column(
              children: serviceModel.unavailableServices.map((service) {
                return ServiceRow(serviceName: service);
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


class ServiceButton extends StatelessWidget {
  final String serviceName;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceButton({super.key, 
    required this.serviceName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        color: isSelected ? Colors.orange : Colors.grey[300],
        child: Text(
          serviceName,
          style: TextStyle(color: isSelected ? Colors.black : null),
        ),
      ),
    );
  }
}

class ServiceRow extends StatelessWidget {
  final String serviceName;

  const ServiceRow({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            color: Colors.grey[300],
            child: Text(serviceName),
          ),
        ),
      ],
    );
  }
}
class MakeServiceAvailableDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const MakeServiceAvailableDialog(this.serviceModel, {Key? key}) : super(key: key);

  @override
  _MakeServiceAvailableDialogState createState() => _MakeServiceAvailableDialogState();
}

class _MakeServiceAvailableDialogState extends State<MakeServiceAvailableDialog> {
  TextEditingController serviceNameController = TextEditingController();
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Service Available'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Unavailable Services:'),
            const SizedBox(height: 8.0),
            Container(
              height: 200,  // Set a fixed height for the ListView
              child: SingleChildScrollView(
                child: Column(
                  children: widget.serviceModel.unavailableServices.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (selectedServices.contains(service)) {
                              selectedServices.remove(service);
                            } else {
                              selectedServices.add(service);
                            }
                            serviceNameController.text = selectedServices.join(', ');
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedServices.contains(service)
                                ? Colors.orange
                                : Colors.yellowAccent,
                          ),
                        ),
                        child: Text(
                          service,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('New Service:'),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: serviceNameController,
              decoration: const InputDecoration(labelText: 'Service Name'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final newService = serviceNameController.text;
                  if (newService.isNotEmpty) {
                    selectedServices.add(newService);
                    serviceNameController.text = '';
                    widget.serviceModel.addAvailableService(newService);
                  }
                });
              },
              child: const Text('Add New Service'),
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
            for (String service in selectedServices) {
              widget.serviceModel.addAvailableService(service);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}


class MakeServiceUnavailableDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const MakeServiceUnavailableDialog(this.serviceModel, {super.key});

  @override
  _MakeServiceUnavailableDialogState createState() =>
      _MakeServiceUnavailableDialogState();
}

class _MakeServiceUnavailableDialogState
    extends State<MakeServiceUnavailableDialog> {
  final TextEditingController serviceNameController = TextEditingController();
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Service Unavailable'),
      content: SingleChildScrollView(  // Added SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Available Services:'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              child: Column(
                children: widget.serviceModel.availableServices.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedServices.contains(service)) {
                            selectedServices.remove(service);
                          } else {
                            selectedServices.add(service);
                          }
                          serviceNameController.text = selectedServices.join(', ');
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          selectedServices.contains(service)
                              ? Colors.orange
                              : Colors.yellowAccent,
                        ),
                      ),
                      child: Text(
                        service,
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
            TextFormField(
              controller: serviceNameController,
              decoration: const InputDecoration(labelText: 'Service Name'),
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
            for (String service in selectedServices) {
              widget.serviceModel.makeServiceUnavailable(service);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}


class RemoveServiceDialog extends StatefulWidget {
  final ServiceModel serviceModel;

  const RemoveServiceDialog(this.serviceModel, {super.key, Key? dialogKey});

  @override
  _RemoveServiceDialogState createState() => _RemoveServiceDialogState();
}

class _RemoveServiceDialogState extends State<RemoveServiceDialog> {
  TextEditingController serviceNameController = TextEditingController();
  String selectedList = 'Available'; // Default selection

  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Service'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select the service list:'),
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
              const Text('Available Services:')
            else
              const Text('Unavailable Services:'),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              child: Column(
                children: (selectedList == 'Available'
                    ? widget.serviceModel.availableServices
                    : widget.serviceModel.unavailableServices)
                    .map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedService = service;
                          serviceNameController.text = selectedService ?? '';
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          selectedService == service
                              ? Colors.orange
                              : Colors.yellowAccent,
                        ),
                      ),
                      child: Text(
                        service,
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
            TextFormField(
              controller: serviceNameController,
              decoration: const InputDecoration(labelText: 'Service Name'),
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
            final selectedServiceName = serviceNameController.text;
            if (selectedServiceName.isNotEmpty) {
              widget.serviceModel.removeService(selectedServiceName, selectedList);
            }
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
