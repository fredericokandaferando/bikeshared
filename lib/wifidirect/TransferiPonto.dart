import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PointsTransferScreen extends StatefulWidget {
  @override
  _PointsTransferScreenState createState() => _PointsTransferScreenState();
}

class _PointsTransferScreenState extends State<PointsTransferScreen> {
  TextEditingController _pointsController = TextEditingController();

  String _userPoints = '100'; // Pontos fictícios do usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 51, 0),
        title: Text(
          'Transferência de Pontos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Meus Pontos: $_userPoints',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _pointsController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    hintText: 'Digite a quantidade de pontos (inteiro)',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 105, 51, 0))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendPoints,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 50),
                  backgroundColor: Color.fromARGB(255, 114, 56, 2),
                ),
                child: Text(
                  'Enviar Pontos',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendPoints() {
    int points = int.tryParse(_pointsController.text) ?? 0;

    // Simulação do envio dos pontos para o outro usuário
    if (points > 0 && points <= int.tryParse(_userPoints)!) {
      setState(() {
        // Atualiza os pontos do usuário após a transferência
        _userPoints = (int.tryParse(_userPoints)! - points).toString();
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Envio dos Pontos'),
            content: Text('Pontos enviados: $points'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro no Envio dos Pontos'),
            content: Text('Pontos inválidos ou insuficientes.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
