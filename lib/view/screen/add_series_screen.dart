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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Série adicionada com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Série'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adicionar Nova Série',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'Nome da Série',
                hintText: 'Digite o nome da série',
                icon: Icons.movie,
                onSaved: (value) => _nome = value!,
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira o nome da série' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'Gênero',
                hintText: 'Digite o gênero da série',
                icon: Icons.category,
                onSaved: (value) => _genero = value!,
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira o gênero' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'Descrição',
                hintText: 'Digite uma breve descrição',
                icon: Icons.description,
                onSaved: (value) => _descricao = value!,
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira a descrição' : null,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'URL da Capa',
                hintText: 'Insira o link da imagem',
                icon: Icons.image,
                onSaved: (value) => _capa = value!,
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira a URL da capa' : null,
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _addSerie,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Salvar Série',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
