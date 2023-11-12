import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> allServices = ['x', 'y', 'z', 'a', 'b', 'c'];
  List<String> displayedServices = [];

  @override
  void initState() {
    super.initState();
    // Initially, display all services
    displayedServices = allServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CANARA BANK",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "VRSEC Branch",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.location_on, color: Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          // Update the UI based on the search result
                          setState(() {
                            displayedServices = filterServices(value);
                          });
                        },
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search_rounded, color: Colors.grey[400]),
                          hintText: "Services Avialable",
                          focusColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            gapPadding: 50.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            gapPadding: 50.0,
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 50.0,
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Display each service in a separate row
                      for (String service in displayedServices)
                        ServiceRow(
                          serviceName: service,
                          isAvailable: allServices.contains(service),
                          onTap: () {
                            // Navigate to the booking page when an available service is clicked
                            if (allServices.contains(service)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookingPage(service)),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> filterServices(String query) {
    // Filter services based on the search query
    return allServices.where((service) => service.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
class ServiceRow extends StatelessWidget {
  final String serviceName;
  final bool isAvailable;
  final VoidCallback onTap;

  const ServiceRow({
    Key? key,
    required this.serviceName,
    required this.isAvailable,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.grey[200] : Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            serviceName,
            style: TextStyle(
              color: isAvailable ? Colors.black : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isAvailable) // Only enable interaction for available services
            GestureDetector(
              onTap: onTap,
              child: Icon(Icons.arrow_forward, color: isAvailable ? Colors.black : Colors.black),
            ),
        ],
      ),
    );
  }
}


class BookingPage extends StatefulWidget {
  final String serviceName;

  const BookingPage(this.serviceName, {super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Define time variables
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 30);
  int lunchStartHour = 12;
  int lunchEndHour = 13;

  // List to keep track of booked slots
  List<bool> isSlotBooked = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${widget.serviceName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 30, // Assuming 30 slots from 10:00 AM to 4:30 PM
              itemBuilder: (context, index) {
                // Calculate the current time for this slot
                final currentTime = startTime.replacing(
                  hour: startTime.hour + (index ~/ 4),
                  minute: (index % 4) * 15,
                );

                // Check if it's a lunch break slot
                bool isLunchBreak = (currentTime.hour >= lunchStartHour &&
                    currentTime.hour < lunchEndHour);

                // Check if the slot is booked
                bool isBooked = isSlotBooked[index];

                return ListTile(
                  leading: Checkbox(
                    value: isBooked,
                    onChanged: isLunchBreak ? null : (value) {
                      setState(() {
                        isSlotBooked[index] = value ?? false;
                      });
                    },
                  ),
                  title: Text(
                    '${currentTime.format(context)} - ${currentTime.replacing(
                      minute: currentTime.minute + 15,
                    ).format(context)}',
                    style: TextStyle(
                      decoration: isBooked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle slot confirmation here, e.g., show a confirmation dialog
              // and process the selected slots.
            },
            child: const Text('Confirm Slot'),
          ),
        ],
      ),
    );
  }
}

