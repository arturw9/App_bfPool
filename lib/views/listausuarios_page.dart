import 'dart:io';

import 'package:flutter/material.dart';
import '../main.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String senha;
  final String email;

  User({required this.senha, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      senha: json['senha'],
    );
  }
}

class UserAPI {
  static Future<List<User>> getUsers() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    var url = Uri.parse('https://10.0.2.2:7070/api/AllUsers');
    var request = await client.getUrl(url);
    var response = await request.close();

    if (response.statusCode == 200) {
      final jsonData =
          json.decode(await response.transform(utf8.decoder).join())
              as List<dynamic>;
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }
}

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = UserAPI.getUsers();
    HttpOverrides.global = MyHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('LISTA DE CLIENTES')),
      ),
      body: FutureBuilder<List<User>>(
        future: UserAPI.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.senha),
                  subtitle: Text(user.email),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// class UserAPI {
//   static Future<List<User>> getUsers() async {
//     HttpClient client = new HttpClient();
//     client.badCertificateCallback =
//         ((X509Certificate cert, String host, int port) => true);

//     var url = 'https://10.0.2.2:7070/api/AllUsers'; // 192.168.1.5

//     Map params = {"email": null, 'senha': null};

//     HttpClientRequest request = await client.getUrl(Uri.parse(url));
//     request.headers.set('content-type', 'application/json');
//     request.add(utf8.encode(json.encode(params)));
//     HttpClientResponse response = await request.close();

//     print("json enviado LISTA USUARIOS: $request");
//     print("Response status LISTA USUARIOS: ${response.statusCode}");

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(request) as List<dynamic>;
//       return jsonData.map((user) => User.fromJson(user)).toList();
//     } else {
//       // print(jsonDecode(response.toString()));
//       return false;
//     }
//   }
// }


//  HttpClient client = new HttpClient();
//     client.badCertificateCallback =
//         ((X509Certificate cert, String host, int port) => true);

//     var url = 'https://10.0.2.2:7070/api/Login'; // 192.168.1.5

//     Map params = {
//       "email": _emailController.text,
//       'senha': _passwordController.text
//     };

//     HttpClientRequest request = await client.postUrl(Uri.parse(url));