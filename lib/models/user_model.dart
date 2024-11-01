class User {
  final String avatarUrl;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String notes;

  User({
    required this.avatarUrl,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.notes,
  });

  // Chuyển đổi dữ liệu từ Firestore sang User
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      avatarUrl: data['avatarUrl'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      notes: data['notes'] ?? '',
    );
  }
}
