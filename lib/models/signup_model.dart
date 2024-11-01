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

  bool IsValid(String email, String password, String phone, String name) {
    // Kiểm tra email bằng regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      print("Email không hợp lệ");
      return false;
    }

    // Kiểm tra password có tối thiểu 6 ký tự
    if (password.length < 6) {
      print("Mật khẩu phải có ít nhất 6 ký tự");
      return false;
    }

    // Kiểm tra số điện thoại chỉ chứa số và có độ dài hợp lệ (ví dụ: 10 ký tự)
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      print("Số điện thoại không hợp lệ");
      return false;
    }

    // Kiểm tra tên không rỗng
    if (name.isEmpty) {
      print("Tên không được để trống");
      return false;
    }

    // Nếu tất cả các kiểm tra đều đúng
    return true;
  }

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
