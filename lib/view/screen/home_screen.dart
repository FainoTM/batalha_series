import 'package:batalha_series/view/screen/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../controller/serie_controller.dart';
import 'add_series_screen.dart';
import 'batalha_screen.dart';

class HomeScreen extends StatelessWidget {
  final _controller = SeriesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha de Séries'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionContainer(
              context,
              title: 'Cadastrar Série',
              description: 'Adicione novas séries à lista',
              icon: Icons.add_circle_outline,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddSeriesScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildOptionContainer(
              context,
              title: 'Iniciar Batalha',
              description: 'Compare suas séries favoritas',
              icon: Icons.sports_kabaddi_outlined,
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BatalhaScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildOptionContainer(
              context,
              title: 'Ranking',
              description: 'Veja as séries mais votadas',
              icon: Icons.leaderboard_outlined,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RankingScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildOptionContainer(
              context,
              title: 'Criar Relatório',
              description: 'Gera um relatório em PDF automaticamente',
              icon: Icons.picture_as_pdf_outlined,
              color: Colors.orange,
              onTap: () => _generatePdf(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionContainer(
      BuildContext context, {
        required String title,
        required String description,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
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
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
              radius: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    final series = await SeriesController().getSeriesOnce();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Relatório de Séries',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              ...series.map((serie) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Nome: ${serie.nome}',
                      style: pw.TextStyle(fontSize: 18),
                    ),
                    pw.Text(
                      'Gênero: ${serie.genero}',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      'Pontuação: ${serie.pontuacao}',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Divider(),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
