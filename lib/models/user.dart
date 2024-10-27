class User {
  final int? id;
  final String username;
  final String email;
  final String created;
  final String updated;
  final String password;

  User({
    this.id,
    required this.username,
    required this.email,
    this.created = '',
    this.updated = '',
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        created: json['created'] ?? '',
        updated: json['updated'] ?? '',
      );

  factory User.empty() => User(
        username: '',
        email: '',
        created: '',
        updated: '',
        password: '',
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'passwordConfirm': password,
      };

  User copyWith({
    String? username,
    String? email,
    String? password,
    String? passwordConfirm,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );
}
