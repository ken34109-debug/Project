import 'package:flutter/material.dart';
import 'database/db_helper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final DBHelper db = DBHelper();

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    final data = await db.getAllUsers();
    setState(() {
      users = data;
    });
  }

  void deleteUser(String username) async {
    await db.deleteUser(username);
    loadUsers();
  }

  void editUsername(String oldName) {
    TextEditingController newName = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Username"),
        content: TextField(
          controller: newName,
          decoration: const InputDecoration(
            hintText: "New username",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await db.updateUsername(
                oldName,
                newName.text.trim(),
              );
              Navigator.pop(context);
              loadUsers();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void editPassword(String username) {
    TextEditingController newPass = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: newPass,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "New password",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await db.updatePassword(
                username,
                newPass.text.trim(),
              );
              Navigator.pop(context);
              loadUsers();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      title: const Text(
        "User Manager",
        style: TextStyle(color: Colors.white), // 🔥 ทำให้ตัวหนังสือขาว
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white), // 🔥 ปุ่ม back เป็นขาว
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

        child: SafeArea(
          child: users.isEmpty
              ? const Center(
                  child: Text(
                    "No users",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return Card(
                      color: Colors.white.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),

                        title: Text(
                          user['username'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          "ID: ${user['id']}",
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blue),
                              onPressed: () {
                                editUsername(user['username']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.lock,
                                  color: Colors.orange),
                              onPressed: () {
                                editPassword(user['username']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                deleteUser(user['username']);
                              },
                            ),
                          ],
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