import 'package:flutter/material.dart';
import '../../controller/serie_controller.dart';
import '../../model/serie_model.dart';



class AddSeriesScreen extends StatefulWidget {
  @override
  _AddSeriesScreenState createState() => _AddSeriesScreenState();
}

class _AddSeriesScreenState extends State<AddSeriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SeriesController();

  String _nome = '';
  String _genero = '';
  String _descricao = '';
  String _capa = '';

  void _addSerie() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newSerie = Serie(
        id: '',
        nome: _nome,
        genero: _genero,
        descricao: _descricao,
        capa: _capa,
      );
      _controller.addSerie(newSerie);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Série adicionada!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Série')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome da Série'),
                validator: (value) =>
                value!.isEmpty ? 'Insira o nome da série' : null,
                onSaved: (value) => _nome = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gênero'),
                validator: (value) =>
                value!.isEmpty ? 'Insira o gênero da série' : null,
                onSaved: (value) => _genero = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _descricao = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'URL da Capa'),
                validator: (value) =>
                value!.isEmpty ? 'Insira a URL da capa' : null,
                onSaved: (value) => _capa = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addSerie,
                child: Text('Salvar Série'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
