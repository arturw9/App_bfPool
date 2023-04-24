import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_crud/views/listausuarios_page.dart';
import 'package:flutter_crud/views/produtos.page.dart';
import 'package:http/http.dart' as http;

class DeletionItemScreen extends StatefulWidget {
  final String nome;
  final String? id;

  const DeletionItemScreen({required this.nome, required this.id});
  @override
  _DeletionItemScreenState createState() => _DeletionItemScreenState();
}

class _DeletionItemScreenState extends State<DeletionItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  bool _loading = false;
  bool _success = false;

  void _submitForm() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final url = 'https://10.0.2.2:7070/api/DeleteItem?id=${widget.id}';
    final body = {
      'email': _nomeController.text,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200 || response.statusCode == 302) {
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
        title: Text('DELETAR PRODUTO'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nome do produto:"),
              Text(
                widget.nome,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 16.0),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Excluir'),
                    ),
              SizedBox(height: 16.0),
              _success
                  ? Text(
                      'Objeto excluído com sucesso!',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
