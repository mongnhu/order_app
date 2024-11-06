import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/firebase/auth_service.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset('assets/images/logo part 1.png'),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              _buildTextField(
                controller: _phoneController,
                labelText: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _registerUser(context),
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                ),
                child: const Text('Have an account? Sign In'),
              ),
              const SizedBox(height: 20),
              _buildSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
            // Customize with a Google icon, e.g. using FontAwesome
            ),
        SizedBox(width: 30),
        CircleAvatar(
            // Customize with a Facebook icon, e.g. using FontAwesome
            ),
      ],
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String phone = _phoneController.text.trim();
    final String name = _nameController.text.trim();

    // Check if email is already registered
    if (await AuthService().isEmailRegistered(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('This email is already registered. Please try another.')),
      );
      return;
    }

    // Proceed with registration if email is not registered
    final newUser = SignUpModel(
      email: email,
      password: password,
      phone: phone,
      name: name,
    );

    try {
      await AuthService().registerUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: $e')),
      );
    }
  }
}
