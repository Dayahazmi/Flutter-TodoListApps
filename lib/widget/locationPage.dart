import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  final String location;

  LocationPage({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location: $location'),
            // Add your specific UI elements based on the location data
          ],
        ),
      ),
    );
  }
}
