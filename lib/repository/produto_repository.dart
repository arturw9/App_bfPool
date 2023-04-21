import 'package:flutter_crud/models/produto.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdutoRepository implements Repository {
  String dataURL = 'https://10.0.2.2:7070/api';
  @override
  Future<String> deletedTodo(User user) async {
    var url = Uri.parse('$dataURL/DeleteUser?email=${user.email}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<User>> getTodoList() async {
    List<User> todoList = [];
    var url = Uri.parse('$dataURL/AllUsers');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(User.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$dataURL/UpdateUsers?email=${user.email}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update user.");
    }
  }

  @override
  Future<String> putCompleted(User user) {
    // TODO: implement putCompleted
    throw UnimplementedError();
  }

  @override
  Future<String> postTodo(User user) {
    // TODO: implement postTodo
    throw UnimplementedError();
  }

  @override
  Future<String> createUser(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<String> createProduto(Produto produto) {
    // TODO: implement createProduto
    throw UnimplementedError();
  }

  @override
  Future<String> deletedTodoProduto(Produto produto) {
    // TODO: implement deletedTodoProduto
    throw UnimplementedError();
  }

  @override
  Future<List<Produto>> getTodoListProduto() async {
    List<Produto> todoList = [];
    var url = Uri.parse('$dataURL/AllItems');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(Produto.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<String> putCompletedProduto(Produto produto) {
    // TODO: implement putCompletedProduto
    throw UnimplementedError();
  }

  @override
  Future<Produto> updateProduto(Produto produto) {
    // TODO: implement updateProduto
    throw UnimplementedError();
  }
}
