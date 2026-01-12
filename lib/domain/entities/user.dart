enum UserRole {
  buyer,
  seller,
}

class User {
  final String id;
  final UserRole role;
  final String displayName;
  final String email;
  final String? phone;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  const User({
    required this.id,
    required this.role,
    required this.displayName,
    required this.email,
    this.phone,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
  });

  User copyWith({
    String? id,
    UserRole? role,
    String? displayName,
    String? email,
    String? phone,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: UserRole.values.byName(json['role']),
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role.name,
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }
}