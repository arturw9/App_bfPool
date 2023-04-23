import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crud/views/listausuarios_page.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _senha;
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _email = widget.user.email;
    _senha = widget.user.senha;
    _emailController.text = _email;
    _senhaController.text = _senha;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListaUsuarios()));
          },
        ),
        title: Text('EDITAR CLIENTE'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              onSaved: (value) {
                _senha = value!;
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
    final url = 'https://10.0.2.2:7070/api/UpdateUsers?id=${widget.user.id}';
    final body = {
      'email': _emailController.text,
      'senha': _senhaController.text,
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
          MaterialPageRoute(builder: (context) => ListaUsuarios()),
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
