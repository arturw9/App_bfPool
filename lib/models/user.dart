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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['senha'] = this.senha;
    return data;
  }
}
