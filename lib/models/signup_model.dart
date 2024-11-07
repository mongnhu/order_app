class SignUpModel {
  final String email;
  final String password;
  final String phone;
  final String name;

  SignUpModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password':
          password, // Lưu password không an toàn. Cần phải mã hóa hoặc không lưu.
      'phone': phone,
      'name': name,
    };
  }
}
