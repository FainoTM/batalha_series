import 'package:flutter/material.dart';
import '../../controller/serie_controller.dart';
import '../../model/serie_model.dart';


class RankingScreen extends StatelessWidget {
  final SeriesController _controller = SeriesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de Séries'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Serie>>(
        stream: _controller.getSeries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final series = snapshot.data!;
          series.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: series.length,
            itemBuilder: (context, index) {
              final serie = series[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Colocação
                    Text(
                      '${index + 1}º',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Conteúdo
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagem
                          CircleAvatar(
                            backgroundImage: NetworkImage(serie.capa),
                            radius: 50,
                          ),
                          SizedBox(height: 8),
                          // Nome
                          Text(
                            serie.nome,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          // Pontuação
                          Text(
                            'Pontos: ${serie.pontuacao}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
