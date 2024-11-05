// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/presentation/ui/home_page.dart';
import 'package:food_delivery/features/pages/sign_up_page.dart';
// import 'package:food_delivery/services/auth_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInPage({super.key});
  // final AuthService _authService = AuthService();
  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Logic để xác thực email và password
    if (email.isNotEmpty && password.isNotEmpty) {
      // Bạn có thể thêm logic gọi API ở đây
      print('Email: $email');
      print('Password: $password');
      // Thực hiện hành động đăng nhập
    } else {
      // Thông báo lỗi nếu email hoặc password rỗng
      print('Vui lòng nhập email và password.');
    }
  }
  // void _signIn(BuildContext context) async {
  //   //   if (_emailController.text.isNotEmpty &&
  //   //       _passwordController.text.isNotEmpty) {
  //   //     User? user = await _authService.signIn(
  //   //       _emailController.text.trim(),
  //   //       _passwordController.text.trim(),
  //   //     );

  //   //     if (user != null) {
  //   //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Đăng nhập thành công!')),
  //       );
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomePage()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Đăng nhập thất bại!')),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
  //     );
  //   }
  // }

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
              const SizedBox(height: 10),
              TextField(
                // controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                // controller: passwordController,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  foregroundColor: Colors.white,
                ),
                onPressed: _login,
                // onPressed: () async {
                //   // // Thực hiện logic đăng nhập
                //   // final success = await ApiService.login(
                //   //   emailController.text,
                //   //   passwordController.text,
                //   // );
                //   // if (success) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomePage()),
                //   );
                //   // } else {
                //   //   // Hiển thị thông báo lỗi
                //   // }
                // },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
