import 'package:flutter/material.dart';
import 'package:food_delivery/features/pages/edit_profile.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/auth_controller.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  _ProFilePageState createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController avatarUrlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Load user data on page initialization
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        setState(() {
          avatarUrlController.text = data?['avatarUrl'] ?? '';
          nameController.text = data?['name'] ?? '';
          phoneController.text = data?['phone'] ?? '';
          addressController.text = data?['address'] ?? '';
          notesController.text = data?['notes'] ?? '';
        });
      } else {
        print("User data does not exist.");
      }
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Get.find<AuthController>().isLoggedIn.value = false;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Complete Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
              if (result == true) {
                _loadUserData(); // Reload data after editing
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Avatar section with update and delete buttons
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: avatarUrlController.text.isNotEmpty
                      ? NetworkImage(avatarUrlController.text)
                      : null,
                  backgroundColor: Colors.teal[100],
                  child: avatarUrlController.text.isEmpty
                      ? Icon(Icons.person, size: 40, color: Colors.white)
                      : null,
                ),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_2),
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                readOnly: true, // Email is typically not editable
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.add_location_alt_rounded),
                ),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  prefixIcon: Icon(Icons.note),
                ),
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.tealAccent[400],
              //     foregroundColor: Colors.white,
              //   ),
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       _saveProfile();
              //     }
              //   },
              //   child: Text('Save Profile'),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _logout,
                child: Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers to free resources
    avatarUrlController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
