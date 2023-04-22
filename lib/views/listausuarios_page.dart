import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crud/controller/UserController.dart';
import 'package:flutter_crud/repository/user_repository.dart';
import 'package:flutter_crud/views/deletionscreean.dart';
import 'package:flutter_crud/views/produtos.page.dart';
import 'package:flutter_crud/views/registrationScreen%20.dart';
import '../main.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  late Future<List<User>> _futureUsers;
  final TextEditingController _searchController = TextEditingController();
  var userController = UserController(UserRepository());

  @override
  void initState() {
    super.initState();
    // _futureUsers = UserAPI.getUsers();
    HttpOverrides.global = MyHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('LISTA DE CLIENTES')),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationScreen()));
            },
          )
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: userController.fetchUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filteredUsers = snapshot.data!
                .where((user) => user.email
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
                .toList();
            return Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(
                        () {}); // Atualiza a tela quando o usuário digitar algo na caixa de pesquisa.
                  },
                ),
                Expanded(
                  child: SafeArea(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Card(
                          child: ListTile(
                            title: Text(user.email),
                            subtitle: Text(user.senha),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.orange,
                                      onPressed: () {
                                        userController
                                            .updateUser(user)
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              content: Text('$value'),
                                            ),
                                          );
                                        });
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeletionScreen(
                                                      email: user.email,
                                                    )));
                                      })
                                ],
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
