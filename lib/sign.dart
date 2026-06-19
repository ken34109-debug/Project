import 'package:flutter/material.dart';
import 'database/db_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final DBHelper db = DBHelper();

  void register() async {
    String user = userController.text.trim();
    String pass = passController.text.trim();
    String confirm = confirmController.text.trim();

    if (user.isEmpty || pass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password not match")),
      );
      return;
    }

    int result = await db.registerUser(user, pass);

    if (result != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register Success")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username already exists")),
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
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.account_circle,
                    size: 140, color: Colors.white),
                const SizedBox(height: 50),

                _buildInput(Icons.person_outline, 'username',
                    controller: userController),

                const SizedBox(height: 15),

                _buildInput(Icons.lock_outline, 'password',
                    isObscure: true,
                    controller: passController),

                const SizedBox(height: 15),

                _buildInput(Icons.lock, 'confirm password',
                    isObscure: true,
                    controller: confirmController),

                const SizedBox(height: 30),

                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= INPUT =================
  Widget _buildInput(
    IconData icon,
    String hint, {
    bool isObscure = false,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 45,
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
                hintStyle: const TextStyle(
                    color: Colors.white70, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= BUTTON =================
  Widget _buildConfirmButton() {
    return SizedBox(
      width: 140,
      height: 40,
      child: ElevatedButton(
        onPressed: register,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008F68),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'CONFIRM',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}