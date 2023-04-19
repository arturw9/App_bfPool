import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/repository/repository.dart';

class UserController {
  final Repository _repository;

  UserController(this._repository);

  Future<List<User>> fetchUserList() async {
    return _repository.getTodoList();
  }

  Future<User> updateUser(User user) async {
    return await _repository.updateUser(user);
  }

  Future<String> deleteUser(User user) async {
    return _repository.deletedTodo(user);
  }

  Future<String> criarUser(User user) async {
    return _repository.createUser(user);
  }
}
