import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_crud/views/listausuarios_page.dart';
import 'package:http/http.dart' as http;

class DeletionScreen extends StatefulWidget {
  final String email;

  const DeletionScreen({required this.email});
  @override
  _DeletionScreenState createState() => _DeletionScreenState();
}

class _DeletionScreenState extends State<DeletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _loading = false;
  bool _success = false;

  void _submitForm() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final url = 'https://10.0.2.2:7070/api/DeleteUser?email=${widget.email}';
    final body = {
      'email': _emailController.text,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200 || response.statusCode == 302) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListaUsuarios()));
    } else {
      // erro ao enviar dados para a API
      // aqui você pode exibir uma mensagem de erro para o usuário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exclusão'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.email,
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
