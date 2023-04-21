import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crud/controller/UserController.dart';
import 'package:flutter_crud/models/produto.dart';
import 'package:flutter_crud/repository/user_repository.dart';
import '../controller/ProdutoController.dart';
import '../main.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../repository/produto_repository.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  late Future<List<Produto>> _futureProdutos;
  final TextEditingController _searchController = TextEditingController();
  var produtoController = ProdutoController(ProdutoRepository());

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
        title: Center(child: Text('LISTA DE PRODUTOS')),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Produto>>(
        future: produtoController.fetchProdutoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filteredUsers = snapshot.data!
                .where((user) => user.nome
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
                        final produto = filteredUsers[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(produto.imagem),
                            ),
                            title: Text(produto.nome),
                            subtitle: Text(produto.valor),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.orange,
                                      onPressed: () {
                                        produtoController
                                            .updateProduto(produto)
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
                                        produtoController
                                            .deleteProduto(produto)
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
