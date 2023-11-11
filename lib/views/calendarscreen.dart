import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _firstDay = DateTime.now();
  DateTime _lastDay = DateTime.now().add(Duration(days: 365));
  DateTime _focusedDay = DateTime.now();
  List<String> _dataUsers = [];
  List<String> _dataItems = [];
  late String _selectedItemUsers = ""; // Item selecionado no DropdownButton
  late String _selectedItemItems = ""; // Item selecionado no DropdownButton
  bool _isLoading = false; // Indicador de carregamento
  String _userInput =
      ''; // Variável para armazenar o texto digitado pelo usuário

  @override
  void initState() {
    super.initState();
    fetchData(); // Chama o método fetchData() para buscar os dados da URL
    _firstDay = DateTime.now();
    _lastDay = _firstDay.add(Duration(days: 365));
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
    });

    final dio = Dio();
    dio.options.validateStatus = (status) => true;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    final responseUsers = await dio.get('https://10.0.2.2:7070/api/AllUsers');

    if (responseUsers.statusCode == 200) {
      final jsonData = responseUsers.data as List<dynamic>;
      final extractedData = jsonData.map((item) {
        final id = item["id"].toString();
        final email = item["email"].toString();
        final senha = item["senha"].toString();

        // Aqui você pode extrair mais chaves conforme necessário

        // Combine os valores em uma única string
        return '$email, $senha'; // Ou a combinação que desejar
      }).toList();
      setState(() {
        _dataUsers = extractedData; // Atualiza a lista de dados
        _selectedItemUsers =
            _dataUsers[0]; // Define o primeiro item como padrão
      });
    }

    final responseItems = await dio.get('https://10.0.2.2:7070/api/AllItems');

    if (responseItems.statusCode == 200) {
      final jsonData = responseItems.data as List<dynamic>;
      final extractedDataItems = jsonData.map((item) {
        final id = item["id"].toString();
        final nome = item["nome"].toString();
        final imagem = item["imagem"].toString();
        final valor = item["valor"].toString();
        final quantidade = item["quantidade"].toString();

        // Aqui você pode extrair mais chaves conforme necessário

        // Combine os valores em uma única string
        return '$nome, $valor'; // Ou a combinação que desejar
      }).toList();
      setState(() {
        _dataItems = extractedDataItems; // Atualiza a lista de dados
        _selectedItemItems =
            _dataItems[0]; // Define o primeiro item como padrão
      });
    }

    setState(() {
      _isLoading = false; // Desativa o indicador de carregamento
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar aviso/notificação'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: _firstDay,
              focusedDay: _focusedDay,
              lastDay: _lastDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (date, events) {
                setState(() {
                  _selectedDay = date;
                });
              },
              // Outras configurações do TableCalendar
            ),
            Center(
                child: _isLoading
                    ? SpinKitCircle(
                        color: Colors.blue) // Indicador de carregamento
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("SELECIONE O CLIENTE",
                                style: TextStyle(color: Colors.blue)),
                          ),
                          DropdownButton<String>(
                            value: _selectedItemUsers,
                            onChanged: (value) {
                              setState(() {
                                _selectedItemUsers = value!;
                              });
                            },
                            items: _dataUsers
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                          ),
                          Text("SELECIONE O ITEM",
                              style: TextStyle(color: Colors.blue)),
                          DropdownButton<String>(
                            value: _selectedItemItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedItemItems = value!;
                              });
                            },
                            items: _dataItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextField(
                              onChanged: (text) {
                                // Este callback é chamado sempre que o texto é alterado
                                setState(() {
                                  _userInput =
                                      text; // Atualiza a variável com o texto digitado
                                });
                              },
                              decoration: const InputDecoration(
                                hintText:
                                    'Digite mensagem de alerta (Opcional).',
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Enviar WhatsApp"),
                                    Icon(Icons.phone),
                                  ],
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              onSurface: Colors.grey,
                            ),
                            onPressed: () {},
                          )
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
