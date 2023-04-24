import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EnviarAvisos extends StatefulWidget {
  @override
  _EnviarAvisosState createState() => _EnviarAvisosState();
}

class _EnviarAvisosState extends State<EnviarAvisos> {
  late String _selectedOption1 = "Opção 1";
  late String _selectedOption2 = "Opção 2";
  String _textFieldValue = "";
  DateTime _selectedDate = DateTime.now();
  bool _isChecked = false;

  final List<String> _options1 = ["Opção 1", "Opção 2", "Opção 3"];
  final List<String> _options2 = ["Opção A", "Opção B", "Opção C"];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ENVIAR AVISO"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Selecione o cliente: "),
            DropdownButton<String>(
              value: _selectedOption1,
              items: _options1
                  .toSet() // Remove valores duplicados
                  .map((option) => DropdownMenuItem(
                        child: Text(option),
                        value: option,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOption1 = value!;
                });
              },
            ),
            // SizedBox(height: 16),
            // DropdownButton<String>(
            //   value: _selectedOption2,
            //   items: _options2
            //       .toSet() // Remove valores duplicados
            //       .map((option) => DropdownMenuItem(
            //             child: Text(option),
            //             value: option,
            //           ))
            //       .toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedOption2 = value!;
            //     });
            //   },
            // ),
            SizedBox(height: 16),
            TextField(
              onChanged: (String newValue) {
                setState(() {
                  _textFieldValue = newValue;
                });
              },
              decoration: InputDecoration(
                hintText: "Digite algo",
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                Text(
                  'Enviar agora',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
