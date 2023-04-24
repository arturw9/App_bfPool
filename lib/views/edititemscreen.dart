import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/produto.dart';
import 'package:flutter_crud/views/listausuarios_page.dart';
import 'package:flutter_crud/views/produtos.page.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class EditItemScreen extends StatefulWidget {
  final Produto produto;

  const EditItemScreen({Key? key, required this.produto}) : super(key: key);

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _nome;
  late String _imagem;
  late String _valor;
  late String _quantidade;
  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _valorController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nome = widget.produto.nome;
    _imagem = widget.produto.imagem;
    _valor = widget.produto.valor;
    _quantidade = widget.produto.quantidade;
    _nomeController.text = _nome;
    _imagemController.text = _imagem;
    _valorController.text = _valor;
    _quantidadeController.text = _quantidade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Produtos()));
          },
        ),
        title: Text('EDITAR ITEM'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _nome = value!;
              },
            ),
            TextFormField(
              controller: _imagemController,
              decoration: InputDecoration(
                labelText: 'Imagem',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _imagem = value!;
              },
            ),
            TextFormField(
              controller: _valorController,
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _valor = value!;
              },
            ),
            TextFormField(
              controller: _quantidadeController,
              decoration: InputDecoration(
                labelText: 'Quantidade',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _quantidade = value!;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    final url = 'https://10.0.2.2:7070/api/UpdateItens?id=${widget.produto.id}';
    final body = {
      'nome': _nomeController.text,
      'imagem': _imagemController.text,
      'valor': _valorController.text,
      'quantidade': _quantidadeController.text,
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 302) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Produtos()),
        );
      } else {
        // erro ao enviar dados para a API
        // aqui você pode exibir uma mensagem de erro para o usuário
      }
    } catch (error) {
      // erro ao fazer a solicitação PUT
      // aqui você pode exibir uma mensagem de erro para o usuário
    }
  }
}
