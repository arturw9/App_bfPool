import 'package:flutter_crud/models/produto.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/repository/repository.dart';

class ProdutoController {
  final Repository _repository;

  ProdutoController(this._repository);

  Future<List<Produto>> fetchProdutoList() async {
    return _repository.getTodoListProduto();
  }

  Future<Produto> updateProduto(Produto produto) async {
    return await _repository.updateProduto(produto);
  }

  Future<String> deleteProduto(Produto produto) async {
    return _repository.deletedTodoProduto(produto);
  }

  Future<String> criarProduto(Produto produto) async {
    return _repository.createProduto(produto);
  }
}
