import 'package:flutter/material.dart';
import 'dart:async';
import 'admin.dart';
import 'database/db_helper.dart';

class StatusPage extends StatefulWidget {
  // 🔥 แก้ไขที่ 1: เพิ่มตัวแปร username เพื่อรับค่าจากหน้า Login
  final String username; 
  
  // 🔥 แก้ไขที่ 2: อัปเดต Constructor ให้บังคับส่งค่า username มาด้วย
  const StatusPage({super.key, required this.username});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final DBHelper db = DBHelper();

  bool isConnected = false;
  bool isScanning = false;
  int signalRange = 0;

  void _toggleConnect() {
    setState(() {
      isScanning = true;
    });

    Timer(const Duration(seconds: 2), () async {
      setState(() {
        isScanning = false;
        isConnected = !isConnected;
        signalRange = isConnected ? 30 : 0;
      });

      // 🔥 แก้ไขที่ 3: ใช้ widget.username เพื่อดึงชื่อจริงไปบันทึกลงฐานข้อมูล
      await db.insertLog(
        widget.username, 
        isConnected ? "CONNECT" : "DISCONNECT",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        // ไม่ใส่ title แล้ว หน้าจอจะดูสะอาดขึ้น
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminPage(),
                    ),
                  ),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popUntil((route) => route.isFirst),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.wifi_tethering,
                  size: 150,
                  color: isConnected
                      ? Colors.greenAccent
                      : Colors.white24,
                ),
                if (isScanning)
                  const SizedBox(
                    width: 170,
                    height: 170,
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                      strokeWidth: 2,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              isScanning
                  ? 'Scanning...'
                  : (isConnected ? 'Connected' : 'Disconnected'),
              style: TextStyle(
                color: isConnected
                    ? Colors.greenAccent
                    : Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (isConnected && !isScanning) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bluetooth_audio,
                      color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Signal Range: $signalRange dBm',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 50),

            _buildStatusButton(
              isScanning
                  ? 'WAIT...'
                  : (isConnected ? 'DISCONNECT' : 'CONNECT'),
              onPressed: isScanning ? () {} : _toggleConnect,
              color: isConnected
                  ? Colors.redAccent
                  : const Color(0xFF28B446),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(
    String label, {
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 240,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}