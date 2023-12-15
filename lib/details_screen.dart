import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias de Clima'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Previsão do Tempo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            NewsCard(
              title: 'Nova Frente Fria Chegando',
              content:
                  'Uma nova frente fria está prevista para chegar na região nos próximos dias. Fique preparado para temperaturas mais baixas e possibilidade de chuva.',
            ),
            NewsCard(
              title: 'Alerta de Tempestade',
              content:
                  'Alerta para possível tempestade no final de semana. Mantenha-se informado e tome precauções necessárias.',
            ),
            // Adicione mais notícias fictícias conforme necessário
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String content;

  const NewsCard({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
