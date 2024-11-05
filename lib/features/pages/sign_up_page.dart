// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/presentation/ui/home_page.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:food_delivery/models/signup_model.dart';

// import '../../services/auth_service.dart';
// import '../../services/firestore_service.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  SignUpPage({super.key});
  // final AuthService _authService = AuthService();
  // final FirestoreService _firestoreService = FirestoreService();

  void _signUp(BuildContext context) async {
    // if (_emailController.text.isNotEmpty &&
    //     _passwordController.text.isNotEmpty) {
    //   SignUpModel newUser = SignUpModel(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim(),
    //     phone: _phoneController.text.trim(),
    //     name: _nameController.text.trim(),
    //   );

    //   User? user = await _authService.signUp(newUser.email, newUser.password);
    //   if (user != null) {
    //     await _firestoreService.createUser(newUser);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Đăng ký thành công!')),
    //     );
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => HomePage()),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Đăng ký thất bại!')),
    //     );
    //   }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Logo

                Image.asset(
                  'assets/images/logo part 1.png',
                ),
                const SizedBox(height: 10),
                // TextField cho email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // TextField cho password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // TextField cho phone
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // TextField cho name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Nút Sign Up
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[400],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _signUp(context),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10),
                // Liên kết đến trang đăng nhập
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: const Text('Have an account?'),
                ),
                const SizedBox(height: 10),
                // Các nút đăng nhập bằng social
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nút Google
                    CircleAvatar(
                        // child: FaIcon(
                        //   FontAwesomeIcons.google,
                        // ),
                        ),
                    // SizedBox(width: 20),
                    // // Nút Twitter
                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   // child: Icon(Icons.twitter),
                    // ),
                    SizedBox(width: 30),
                    // Nút Facebook
                    CircleAvatar(
                        // child: FaIcon(FontAwesomeIcons.facebookF),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    // Tạo đối tượng SignUpModel
    SignUpModel newUser = SignUpModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
      name: _nameController.text.trim(),
    );

    try {
      // Lưu vào Firestore
      // await FirebaseFirestore.instance.collection('users').add(newUser.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );

      // Chuyển đến trang đăng nhập hoặc trang chính
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thất bại: $e')),
      );
    }
  }

  Widget _buildTextField(IconData icon, String hint,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
