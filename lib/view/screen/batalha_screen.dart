import 'package:flutter/material.dart';
import '../../controller/serie_controller.dart';
import '../../model/serie_model.dart';


class BatalhaScreen extends StatefulWidget {
  @override
  _BatalhaScreenState createState() => _BatalhaScreenState();
}

class _BatalhaScreenState extends State<BatalhaScreen> {
  final SeriesController _controller = SeriesController();
  Serie? _selectedSerie1;
  Serie? _selectedSerie2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Batalha de Séries')),
      body: StreamBuilder<List<Serie>>(
        stream: _controller.getSeries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final series = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSerieSection(
                  context,
                  "Série 1",
                  _selectedSerie1,
                  series,
                      (serie) {
                    setState(() {
                      _selectedSerie1 = serie;
                    });
                  },
                ),
                SizedBox(height: 24),
                Text(
                  "VS",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildSerieSection(
                  context,
                  "Série 2",
                  _selectedSerie2,
                  series,
                      (serie) {
                    setState(() {
                      _selectedSerie2 = serie;
                    });
                  },
                ),
                SizedBox(height: 32),
                if (_selectedSerie1 != null && _selectedSerie2 != null)
                  Column(
                    children: [
                      Text(
                        'Qual série venceu?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _controller.updatePontuacao(_selectedSerie1!.id, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${_selectedSerie1!.nome} venceu!'),
                                    ),
                                  );
                                  setState(() {
                                    _selectedSerie1 = null;
                                    _selectedSerie2 = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  '${_selectedSerie1!.nome}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _controller.updatePontuacao(_selectedSerie2!.id, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${_selectedSerie2!.nome} venceu!'),
                                    ),
                                  );
                                  setState(() {
                                    _selectedSerie1 = null;
                                    _selectedSerie2 = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  '${_selectedSerie2!.nome}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSerieSection(
      BuildContext context,
      String label,
      Serie? selectedSerie,
      List<Serie> series,
      Function(Serie) onSelected,
      ) {
    return GestureDetector(
      onTap: () async {
        final selected = await showDialog<Serie>(
          context: context,
          builder: (context) => Dialog(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: series.length,
              itemBuilder: (context, index) {
                final serie = series[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(serie.capa),
                  ),
                  title: Text(serie.nome),
                  subtitle: Text(serie.genero),
                  onTap: () {
                    Navigator.pop(context, serie);
                  },
                );
              },
            ),
          ),
        );
        if (selected != null) {
          onSelected(selected);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedSerie != null ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            selectedSerie != null
                ? Column(
              children: [
                Image.network(
                  selectedSerie.capa,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                Text(
                  selectedSerie.nome,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Gênero: ${selectedSerie.genero}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  'Pontos: ${selectedSerie.pontuacao}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
                : Center(
              child: Text(
                'Selecionar Série',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
