import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Smart_Health'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              _buildFeatureButton(
                context,
                'Toh kaise hai aap log ?',
                Colors.white,
                '/toh_kaise',
              ),
              const SizedBox(height: 10),
              _buildFeatureButton(
                context,
                'Appointment Booking',
                Colors.blue,
                '/appointment_booking',
              ),
              const SizedBox(height: 10),
              _buildFeatureButton(
                context,
                'Medical Report',
                Colors.green,
                '/medical_report',
              ),
              const SizedBox(height: 10),
              _buildFeatureButton(
                context,
                'Ambulance Booking',
                Colors.red,
                '/ambulance_booking',
              ),
              const SizedBox(height: 10),
              _buildFeatureButton(
                context,
                'Help',
                Colors.yellow,
                '/help',
              ),
              const SizedBox(height: 10),
              _buildFeatureButton(
                context,
                'About Us',
                Colors.purple,
                '/about_us',
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
      BuildContext context, String text, Color color, String routeName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}
