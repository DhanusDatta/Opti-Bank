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
  List<String> availableServices = ['x', 'y', 'a', 'b'];
  List<String> unavailableServices = ['z', 'c'];

  void updateSearchResult(String query) {
    // Your search logic here
    // This method can be used to dynamically filter displayed services
    // based on the search query entered by the user
    // For simplicity, it is not implemented in this example
  }

  void addAvailableService(String serviceName) {
    if (!availableServices.contains(serviceName)) {
      availableServices.add(serviceName);
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
  const BankEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var serviceModel = ServiceModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Employee App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  builder: (context) => AddServiceDialog(serviceModel),
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Available Services:'),
          const SizedBox(height: 8.0),
          for (String service in serviceModel.availableServices)
            ServiceRow(serviceName: service),
          const SizedBox(height: 16.0),
          const Text('Unavailable Services:'),
          const SizedBox(height: 8.0),
          for (String service in serviceModel.unavailableServices)
            ServiceRow(serviceName: service),
        ],
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
class AddServiceDialog extends StatelessWidget {
  final ServiceModel serviceModel;
  final TextEditingController serviceNameController = TextEditingController();

  AddServiceDialog(this.serviceModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Available Service'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: serviceNameController,
            decoration: const InputDecoration(labelText: 'Service Name'),
          ),
        ],
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
            serviceModel.addAvailableService(serviceNameController.text);
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
class MakeServiceUnavailableDialog extends StatelessWidget {
  final ServiceModel serviceModel;
  final TextEditingController serviceNameController = TextEditingController();

  MakeServiceUnavailableDialog(this.serviceModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Service Unavailable'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Available Services:'),
          for (String service in serviceModel.availableServices)
            ServiceRow(serviceName: service),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: serviceNameController,
            decoration: const InputDecoration(labelText: 'Service Name'),
          ),
        ],
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
            serviceModel.makeServiceUnavailable(serviceNameController.text);
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

  const RemoveServiceDialog(this.serviceModel, {super.key});

  @override
  _RemoveServiceDialogState createState() => _RemoveServiceDialogState();
}

class _RemoveServiceDialogState extends State<RemoveServiceDialog> {
  TextEditingController serviceNameController = TextEditingController();
  String selectedList = 'Available'; // Default selection

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
            for (String service in
            selectedList == 'Available'
                ? widget.serviceModel.availableServices
                : widget.serviceModel.unavailableServices)
              ServiceRow(serviceName: service),
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
            widget.serviceModel.removeService(
                serviceNameController.text, selectedList);
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
