import 'package:flutter/material.dart';
import 'device.dart';   
import 'activity.dart'; 
import 'setting.dart';  

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF030421), 
              Color(0xFF000054), 
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Admin Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    
                    _buildAdminCard(
                      context,
                      title: 'Device Management',
                      subtitle: 'Add or Delete Bluetooth Locks',
                      icon: Icons.bluetooth_searching,
                      color: Colors.blueAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DevicePage()),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),

                    
                    _buildAdminCard(
                      context,
                      title: 'Activity Log',
                      subtitle: 'User connection history',
                      icon: Icons.history_toggle_off,
                      color: Colors.orangeAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ActivityPage()),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    
                    _buildAdminCard(
                      context,
                      title: 'Settings',
                      subtitle: 'Change Username & Password',
                      icon: Icons.settings_applications,
                      color: Colors.tealAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildAdminCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), 
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Row(
          children: [
           
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            
           
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            
           
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}