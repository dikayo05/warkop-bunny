class Profile {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String phoneNumber;
  final String? role;

  Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.phoneNumber,
    this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'phone_number': phoneNumber,
      'role': role,
    };
  }
}
