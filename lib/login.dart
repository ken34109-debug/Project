import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'status.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final DBHelper db = DBHelper();

 
  void login() async {
    String user = userController.text.trim();
    String pass = passController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    
    bool success = await db.loginUser(user, pass);

    if (success) {
      
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StatusPage(username: user), 
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed: Incorrect username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
            colors: [
              Color(0xFF030421),
              Color(0xFF000054),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Icon(Icons.account_circle, size: 150, color: Colors.white),

              const SizedBox(height: 50),

              
              _buildInputRow(
                Icons.person_outline, 
                'username',
                controller: userController
              ),

              const SizedBox(height: 15),

              
              _buildInputRow(
                Icons.lock_outline, 
                'password',
                isObscure: true,
                controller: passController
              ),

              const SizedBox(height: 35),

              // ปุ่มยืนยัน
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildInputRow(
    IconData icon,
    String hint, {
    bool isObscure = false,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
            child: TextField(
              controller: controller,
              obscureText: isObscure,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _buildConfirmButton() {
    return SizedBox(
      width: 140,
      height: 42,
      child: ElevatedButton(
        onPressed: login,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008F68),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
        ),
        child: const Text(
          'CONFIRM',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}