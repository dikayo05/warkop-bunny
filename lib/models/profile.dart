class Profile {
  String? id;
  String? createdAt;
  String? updatedAt;
  String name;
  String? phoneNumber;
  String role;

  Profile({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.phoneNumber,
    this.role = 'user',
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json['id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    name: json['name'],
    phoneNumber: json['phone_number'] as String?,
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    'updated_at': updatedAt,
    'name': name,
    'phone_number': phoneNumber,
    'role': role,
  };
}
