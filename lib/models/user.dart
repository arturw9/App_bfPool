class User {
  final String email;
  final String senha;

  User({required this.email, required this.senha});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      senha: json['senha'],
    );
  }
}
