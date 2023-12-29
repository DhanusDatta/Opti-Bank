import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bank.dart';

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
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.0),
                  ),
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

                      // Display the services using ServiceList widget
                      ServiceList(serviceModel: serviceModel),
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

class ServiceList extends StatelessWidget {
  final ServiceModel serviceModel;

  const ServiceList({Key? key, required this.serviceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: serviceModel.availableServices.map((service) {
        return GestureDetector(
          onTap: () {
            if (serviceModel.availableServices.contains(service)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingPage(serviceName: service)),
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
    );
  }
}

class BookingPage extends StatelessWidget {
  final String serviceName;

  const BookingPage({Key? key, required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for $serviceName'),
      ),
      body: Center(
        child: Text('This is the booking page for $serviceName'),
      ),
    );
  }
}
