import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_crud/views/home_page.dart';
import 'package:flutter_crud/views/listausuarios_page.dart';
import 'package:flutter_crud/views/produtos.page.dart';
import 'package:http/http.dart' as http;

class CadastrarProdutos extends StatefulWidget {
  @override
  _CadastrarProdutosState createState() => _CadastrarProdutosState();
}

class _CadastrarProdutosState extends State<CadastrarProdutos> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _valorController = TextEditingController();
  final _quantidadeController = TextEditingController();

  bool _loading = false;

  void _submitForm() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final url = 'https://10.0.2.2:7070/api/CriarItem';
    final body = {
      'nome': _nomeController.text,
      'imagem': _imagemController.text,
      'valor': _valorController.text,
      'quantidade': _quantidadeController.text,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Produtos()));
    } else {
      // erro ao enviar dados para a API
      // aqui você pode exibir uma mensagem de erro para o usuário
    }
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
        title: Text('CADASTRO DE PRODUTOS'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagemController,
                decoration: InputDecoration(
                  labelText: 'Imagem',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valorController,
                decoration: InputDecoration(
                  labelText: 'Valor',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo é obrigatório.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Cadastrar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
