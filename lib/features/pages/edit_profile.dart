import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String cloudinaryApiKey = '978721145967327';
const String cloudinaryApiSecret = 'ZwD21p--UxkqNkYD_fitu7hi64U';
const String cloudinaryCloudName = 'dpejj910e';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  final ImagePicker _picker = ImagePicker();

  // String? _avatarUrl;
  String _avatarUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

// Hàm tải ảnh lên Cloudinary
  Future<String?> _uploadImageToCloudinary(File imageFile) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload');
    final request = http.MultipartRequest('POST', url);

    // Các trường cần thiết
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final signature = _generateCloudinarySignature(
        {'timestamp': timestamp, 'upload_preset': 'profile_pic'});

    request.fields['upload_preset'] = 'profile_pic';
    request.fields['api_key'] = cloudinaryApiKey;
    request.fields['timestamp'] = timestamp;
    request.fields['signature'] = signature;

    // Thêm tệp ảnh
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = json.decode(responseData.body);
      return data['secure_url'];
    } else {
      print("Lỗi tải ảnh lên Cloudinary: ${response.reasonPhrase}");
      return null;
    }
  }

// Hàm tạo chữ ký Cloudinary
  String _generateCloudinarySignature(Map<String, String> params) {
    final sortedKeys = params.keys.toList()..sort();
    final signatureBase =
        sortedKeys.map((key) => '$key=${params[key]}').join('&');
    final digest =
        sha1.convert(utf8.encode('$signatureBase$cloudinaryApiSecret'));
    return digest.toString(); // Trả về mã hex thay vì base64
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final data = userDoc.data();
      if (data != null) {
        setState(() {
          avatarUrlController.text = data['avatarUrl'] ?? '';
          nameController.text = data['name'] ?? '';
          phoneController.text = data['phone'] ?? '';
          addressController.text = data['address'] ?? '';
          notesController.text = data['notes'] ?? '';
        });
      }
    }
  }

  // Save file locally
  Future<String> _saveFileLocally(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${file.uri.pathSegments.last}';
    await file.copy(filePath);
    return filePath;
  }

  // Save updated profile data to Firestore
  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        // 'avatarUrl': avatarUrlController.text,
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'notes': notesController.text,
        'avatarUrl': _avatarUrl,
      }, SetOptions(merge: true));

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('_avatarUrl', _avatarUrl);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')));
      Navigator.pop(context, true);
    }
  }

  Future<void> _uploadImageToCloudinaryAndSave() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final selectedImage = File(pickedFile.path);

      // Nén ảnh để giảm dung lượng lưu trữ (tuỳ chọn)
      final compressedImage = await FlutterImageCompress.compressWithFile(
        selectedImage.absolute.path,
        quality: 75,
      );

      if (compressedImage != null) {
        final file = await File('${selectedImage.path}_compressed.jpg')
            .writeAsBytes(compressedImage);

        // Tải ảnh lên Cloudinary
        final imageUrl = await _uploadImageToCloudinary(file);
        if (imageUrl != null) {
          setState(() {
            _avatarUrl = imageUrl;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Ảnh đại diện đã được tải lên Cloudinary!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi khi tải ảnh lên Cloudinary.')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Colors.fromARGB(255, 253, 251, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Avatar section
              Center(
                  child: CircleAvatar(
                radius: 40,
                backgroundImage: _avatarUrl.isNotEmpty
                    ? NetworkImage(_avatarUrl) // Hiển thị ảnh từ URL
                    : null,
                child: _avatarUrl.isEmpty
                    ? Icon(Icons.person,
                        size: 40,
                        color: Colors
                            .white) // Nếu không có ảnh, hiển thị icon mặc định
                    : null,
                backgroundColor: Colors.teal[100],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.upload),
                    label: Text('Upload Image'),
                    onPressed: _uploadImageToCloudinaryAndSave,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Form fields
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
                readOnly: true,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 20),

              // Save button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProfile();
                  }
                },
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    avatarUrlController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
