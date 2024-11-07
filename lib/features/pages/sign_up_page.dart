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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Gán key cho Form để quản lý trạng thái
            child: Column(
              children: [
                Image.asset('assets/images/logo part 1.png'),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                  validator: _validateEmail,
                ),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: _validatePassword,
                ),
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Phone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Name',
                  icon: Icons.person,
                  validator: _validateName,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
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
        validator: validator,
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
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, proceed with registration
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String phone = _phoneController.text.trim();
      final String name = _nameController.text.trim();

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

  // Hàm kiểm tra email
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.(com|vn|org|net|edu)$');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  // Hàm kiểm tra mật khẩu
  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // Hàm kiểm tra số điện thoại
  String? _validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return 'Phone number is required';
    final phoneRegex = RegExp(r'^\d{10,}$');
    if (!phoneRegex.hasMatch(phone)) return 'Enter a valid phone number';
    return null;
  }

  // Hàm kiểm tra tên
  String? _validateName(String? name) {
    if (name == null || name.isEmpty) return 'Name is required';
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(name))
      return 'Enter a valid name (letters and spaces only)';
    return null;
  }
}
