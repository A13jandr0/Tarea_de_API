class User {
  final int? id;
  final String name;
  final String email;
  final String gender;
  final String status;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? 'male',
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
    };
  }
}
