import 'package:flutter/material.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';

class ProFilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController avatarUrlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // final String avatarUrl;
  // final String name;
  // final String phone;
  // final String email;
  // final String address;
  // final String notes;

  // ProFilePage({
  //   required this.avatarUrl,
  //   required this.name,
  //   required this.phone,
  //   required this.email,
  //   required this.address,
  //   required this.notes,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: avatarUrlController,
                decoration: InputDecoration(labelText: 'Avatar URL'),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   _showInfoDialog();
                  // }
                  // onPressed: _saveProfile,
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text('log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Thông tin tài khoản'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           CircleAvatar(
  //             radius: 50,
  //             backgroundImage: NetworkImage(avatarUrl),
  //           ),
  //           SizedBox(height: 16),
  //           Text(
  //             name,
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Số điện thoại: $phone',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Email: $email',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Địa chỉ: $address',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Ghi chú: $notes',
  //             style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  //           ),
  //           Spacer(),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Logic xử lý đăng xuất
  //               // Navigator.pop(context); // Ví dụ chuyển về màn hình đăng nhập
  //               Navigator.pop(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => SignInPage()),
  //               );
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.red,
  //             ),
  //             child: Text('Đăng xuất'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
