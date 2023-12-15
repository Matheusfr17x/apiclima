// Importa os pacotes necessários do Flutter e do Dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';

// Função principal que inicializa o aplicativo Flutter
void main() {
  runApp(MyApp());
}

// Classe principal do aplicativo, que é um widget 
class MyApp extends StatelessWidget {
  // Configuração básica do aplicativo, como título e tema
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       // Define a tela inicial do aplicativo como MyHomePage
      home: MyHomePage(),
    );
  }
}
// Classe que representa a tela principal do aplicativo
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
// Estado da tela principal
class _MyHomePageState extends State<MyHomePage> {
  // Variáveis para armazenar o nome da cidade, chave da API e dados meteorológicos
  String cityName = 'aguanil';
  String apiKey = '9f37f6bcb06be3fd7efd30bb8d50edb0';
  Map<String, dynamic> weatherData = {};

// Método chamado quando o estado é inicializado
  @override
  void initState() {
    super.initState();
    // Chama o método para buscar os dados meteorológicos
    fetchWeatherData();
  }

  // Método assíncrono para buscar dados meteorológicos da API
  Future<void> fetchWeatherData() async {
    // Faz uma requisição HTTP para a API do OpenWeatherMap
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName,BR&appid=$apiKey'),
    );
    // Verifica se a resposta da API foi bem-sucedida (código 200)
    if (response.statusCode == 200) {
      // Atualiza o estado do widget com os dados meteorológicos obtidos
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      // Se a resposta não foi bem-sucedida, lança uma exceção
      throw Exception('Falha ao carregar dados meteorológicos');
    }
  }

// Método responsável por construir a interface da tela
  @override
  Widget build(BuildContext context) {
    // Barra de navegação superior
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo - $cityName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getWeatherIcon(),
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Temperatura: ${(weatherData['main']['temp'] / 10).toStringAsFixed(2)}°C',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Condição: ${weatherData['weather'][0]['description']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Temperatura Máxima: ${(weatherData['main']['temp_max'] / 10).toStringAsFixed(2)}°C',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Temperatura Mínima: ${(weatherData['main']['temp_min'] / 10).toStringAsFixed(2)}°C',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Umidade: ${weatherData['main']['humidity']}%',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Velocidade do Vento: ${weatherData['wind']['speed']} m/s',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                  
                    MaterialPageRoute(builder: (context) => DetailsScreen()),
                        
                    );
                  
                },
                child: Text('Mais Informações'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getWeatherIcon() {
    String condition =
        weatherData['weather'][0]['main'].toString().toLowerCase();

    switch (condition) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      default:
        return Icons.wb_sunny;
    }
  }
}
