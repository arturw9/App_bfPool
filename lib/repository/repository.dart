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
}
