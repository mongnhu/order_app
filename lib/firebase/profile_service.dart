// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> uploadAvatar() async {
//     // Step 1: Select a file using file_picker
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image, // Restrict to images only
//     );

//     // Step 2: Exit if no file is selected
//     if (result == null) return;

//     // Step 3: Get the file path
//     File file = File(result.files.single.path!);
//     final user = _auth.currentUser;
//     if (user == null) return;

//     // Step 4: Define the file path in Firebase Storage
//     String fileName =
//         'avatars/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.png';

//     try {
//       // Step 5: Upload the file to Firebase Storage
//       final uploadTask =
//           await FirebaseStorage.instance.ref(fileName).putFile(file);

//       // Step 6: Get the download URL of the uploaded image
//       final downloadURL = await uploadTask.ref.getDownloadURL();

//       // Step 7: Update Firestore with the new avatar URL
//       await _firestore.collection('users').doc(user.uid).update({
//         'avatarUrl': downloadURL,
//       });

//       print("Avatar uploaded successfully and URL updated in Firestore!");
//     } catch (e) {
//       print("Error uploading avatar: $e");
//     }
//   }
// }
