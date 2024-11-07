






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery/models/user_model.dart';

// class ProfileFormPage extends StatefulWidget {
//   @override
//   _ProfileFormPageState createState() => _ProfileFormPageState();
// }

// class _ProfileFormPageState extends State<ProfileFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final TextEditingController avatarUrlController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController notesController = TextEditingController();

//   Future<void> _saveUserProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Create a UserModel object from the form inputs
//       UserModel newUser = UserModel(
//         email: emailController.text.trim(),
//         phone: phoneController.text.trim(),
//         name: nameController.text.trim(),
//         avatarUrl: avatarUrlController.text.trim(),
//         address: addressController.text.trim(),
//         notes: notesController.text.trim(),
//       );

//       try {
//         // Save the user data to Firestore under the 'users' collection
//         await FirebaseFirestore.instance
//             .collection('users')
//             .add(newUser.toMap());

//         // Show confirmation message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('User profile saved successfully!')),
//         );
//       } catch (e) {
//         // Show error message if save fails
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save user profile: $e')),
//         );
//       }
//     }
//   }

//   // Function to show a dialog with entered information
//   void _showInfoDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Thông tin tài khoản'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Avatar URL: ${avatarUrlController.text}'),
//               Text('Name: ${nameController.text}'),
//               Text('Phone: ${phoneController.text}'),
//               Text('Email: ${emailController.text}'),
//               Text('Address: ${addressController.text}'),
//               Text('Notes: ${notesController.text}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin tài khoản'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: avatarUrlController,
//                 decoration: InputDecoration(labelText: 'Avatar URL'),
//               ),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextFormField(
//                 controller: phoneController,
//                 decoration: InputDecoration(labelText: 'Phone'),
//               ),
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               TextFormField(
//                 controller: addressController,
//                 decoration: InputDecoration(labelText: 'Address'),
//               ),
//               TextFormField(
//                 controller: notesController,
//                 decoration: InputDecoration(labelText: 'Notes'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 // onPressed: () {
//                 //   // if (_formKey.currentState!.validate()) {
//                 //   //   _showInfoDialog();
//                 //   // }
//                 onPressed: _saveProfile,
//                 // },
//                 child: Text('save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up controllers
//     avatarUrlController.dispose();
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     addressController.dispose();
//     notesController.dispose();
//     super.dispose();
//   }
// }
