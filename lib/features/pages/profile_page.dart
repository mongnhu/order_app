import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/features/pages/edit_profile.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  _ProFilePageState createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // String? _avatarUrl;
  String _avatarUrl = '';

  final TextEditingController avatarUrlController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<String?> _getAvatarUrlFromPrefs() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('_avatarUrl');
  }

  // Future<void> _loadUserData() async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     final userDoc = await _firestore.collection('users').doc(user.uid).get();
  //     final data = userDoc.data();
  //     if (data != null) {
  //       setState(() {
  //         _avatarUrl = data['avatarUrl'];
  //         // avatarUrlController.text = data['avatarUrl'] ?? '';
  //         emailController.text = data['email'] ?? '';
  //         nameController.text = data['name'] ?? '';
  //         phoneController.text = data['phone'] ?? '';
  //         addressController.text = data['address'] ?? '';
  //         notesController.text = data['notes'] ?? '';
  //       });
  //     }
  //   }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Fetching user document from Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final data = userDoc.data();

      if (data != null) {
        setState(() {
          _avatarUrl = data['avatarUrl'] ?? '';
          emailController.text = data['email'] ?? '';
          nameController.text = data['name'] ?? '';
          phoneController.text = data['phone'] ?? '';
          addressController.text = data['address'] ?? '';
          notesController.text = data['notes'] ?? '';
        });
      } else {
        // If no Firestore data, check SharedPreferences
        final sharedPreferences = await SharedPreferences.getInstance();
        final avatarUrlFromPrefs =
            sharedPreferences.getString('_avatarUrl') ?? '';
        setState(() {
          _avatarUrl = avatarUrlFromPrefs;
        });
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
        title: Text('Complete Profile'),
        backgroundColor: const Color.fromARGB(255, 43, 114, 207),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.black),
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
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
              child: _avatarUrl == null
                  ? Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
              backgroundColor: const Color.fromARGB(255, 89, 193, 185),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_2_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone_android_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_history_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
                prefixIcon: Icon(Icons.note_alt_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                // backgroundColor: const Color.fromARGB(255, 232, 13, 13),
                foregroundColor: const Color.fromARGB(255, 202, 59, 59),
              ),
              onPressed: _logout,
              label: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    avatarUrlController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
