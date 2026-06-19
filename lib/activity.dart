import 'package:flutter/material.dart';
import 'database/db_helper.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final DBHelper db = DBHelper();
  List<Map<String, dynamic>> logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() async {
    
    final data = await db.getAllLogs(); 
    setState(() {
      logs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Log History", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF030421), Color(0xFF000054)],
          ),
        ),
        child: SafeArea(
          child: logs.isEmpty
              ? const Center(child: Text("No logs available", style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    final bool isConnect = log['status'] == "CONNECT"; // เช็คจากคอลัมน์ status

                    return Card(
                      color: Colors.white.withOpacity(0.1),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Icon(
                          isConnect ? Icons.login : Icons.logout,
                          color: isConnect ? Colors.greenAccent : Colors.redAccent,
                        ),
                        title: Text(
                          "User: ${log['user']}", 
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Date: ${log['date']} | Time: ${log['time']}", 
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        trailing: Text(
                          log['status'], 
                          style: TextStyle(
                            color: isConnect ? Colors.greenAccent : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}