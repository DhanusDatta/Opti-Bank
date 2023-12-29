import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/bank.dart';
import 'models/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MaterialApp(
    title: 'Login Page',
    home: LoginPage(),
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer<ServiceModel>(
        builder: (context, serviceModel, child) {
          if (serviceModel.isLoggedIn) {
            return const HomeScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var serviceModel = Provider.of<ServiceModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            serviceModel.updateSearchResult(value);
                          });
                        },
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search_rounded, color: Colors.grey[400]),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Display the services using ServiceList widget
                      Column(
                        children: serviceModel.availableServices.map((service) {
                          return GestureDetector(
                            onTap: () {
                              if (serviceModel.availableServices.contains(service)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage(serviceName: service),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    service,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.book,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
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
}

class BookingPage extends StatefulWidget {
  final String serviceName;

  const BookingPage({Key? key, required this.serviceName}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String selectedSlot = '';
  TextEditingController customerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var serviceModel = Provider.of<ServiceModel>(context);

    // Get the available slots for the selected service
    final availableSlots = serviceModel.getAvailableSlotsForService(widget.serviceName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${widget.serviceName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a slot for ${widget.serviceName}:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<String>(
              value: selectedSlot,
              items: availableSlots.map((slot) {
                return DropdownMenuItem(
                  value: slot, // Ensure that each value is unique
                  child: Text(slot),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSlot = value!;
                });
              },
            ),

            const SizedBox(height: 16.0),
            TextFormField(
              controller: customerNameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform booking logic here
                if (selectedSlot.isNotEmpty && customerNameController.text.isNotEmpty) {
                  // Save the booking details (service name, booked slot, customer name)
                  // You can use these details to update your model or perform any other actions
                  final bookedService = widget.serviceName;
                  final bookedSlot = selectedSlot;
                  final bookedBy = customerNameController.text;

                  // Print or use the booked details as needed
                  print('Service: $bookedService, Slot: $bookedSlot, Booked By: $bookedBy');

                  // You can also navigate back or perform other actions after booking
                  Navigator.pop(context);
                }
              },
              child: Text('Book Slot'),
            ),
          ],
        ),
      ),
    );
  }
}