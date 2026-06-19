import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Device Management', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF030421), Color(0xFF000054)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Icon(
                Icons.bluetooth_searching,
                size: 100,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 50),

              
              _buildDeviceButton(
                context,
                label: 'ADD DEVICE',
                icon: Icons.add_circle_outline,
                color: const Color(0xFF28B446), 
                onTap: () {
                  print("Scanning for Bluetooth devices...");
                  
                },
              ),

              const SizedBox(height: 25),

             
              _buildDeviceButton(
                context,
                label: 'DELETE DEVICE',
                icon: Icons.remove_circle_outline,
                color: Colors.redAccent, 
                onTap: () {
                  print("Selecting device to delete...");
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildDeviceButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 280,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 28),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.5),
        ),
      ),
    );
  }
}