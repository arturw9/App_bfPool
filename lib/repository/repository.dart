import 'package:flutter_crud/models/produto.dart';
import 'package:flutter_crud/models/user.dart';

abstract class Repository {
  // get
  Future<List<User>> getTodoList();
  // patch
  Future<User> updateUser(User user);
  // put
  Future<String> putCompleted(User user);
  // delete
  Future<String> deletedTodo(User user);
  // post
  Future<String> createUser(User user);

  // get
  Future<List<Produto>> getTodoListProduto();
  // patch
  Future<Produto> updateProduto(Produto produto);
  // put
  Future<String> putCompletedProduto(Produto produto);
  // delete
  Future<String> deletedTodoProduto(Produto produto);
  // post
  Future<String> createProduto(Produto produto);
}
