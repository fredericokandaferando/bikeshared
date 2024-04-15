import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'messagem.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();

  // Variáveis relacionadas à gravação de áudio
  bool _isRecording = false;
  String _recordedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 105, 51, 0),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.group_add),
                onPressed: () {
                  // Lógica para criar grupo WiFi Direct
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  // Lógica para iniciar conexão WiFi Direct
                },
              ),
              IconButton(
                icon: Icon(Icons.connect_without_contact_rounded),
                onPressed: () {
                  // Lógica para conectar-se a um grupo WiFi Direct
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Lógica para pesquisar dispositivos WiFi Direct próximos
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return message.isSentByMe
                    ? _buildSentMessage(message.text)
                    : _buildReceivedMessage(message.text);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildSentMessage(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: BubbleSpecialThree(
        text: text,
        color: Color.fromARGB(255, 105, 51, 0),
        tail: true,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildReceivedMessage(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: BubbleSpecialThree(
        text: text,
        color: Colors.green,
        tail: true,
        isSender: false,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
            onPressed: () {
              if (!_isRecording) {
                _startRecording();
              } else {
                _stopRecording();
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (text) {
                setState(() {
                  messages.add(Message(text: text, isSentByMe: true));
                });
                _textController.clear();
              },
              decoration: InputDecoration(
                hintText: 'Mensagem',
                hintStyle: TextStyle(color: Color.fromARGB(255, 105, 51, 0)),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      messages.add(Message(
                          text: _textController.text, isSentByMe: true));
                    });
                    _textController.clear();
                  },
                  icon:
                      Icon(Icons.send, color: Color.fromARGB(255, 105, 51, 0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });

    // Lógica para iniciar a gravação de áudio
    // Substitua esta lógica com a lógica real de gravação de áudio
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });

    // Lógica para parar a gravação de áudio
    // Substitua esta lógica com a lógica real de parar a gravação de áudio

    // Após a gravação, se houver sucesso, defina o caminho do arquivo gravado
    _recordedFilePath =
        '/path/to/recorded/audio/file.mp3'; // Exemplo de caminho de arquivo gravado
    setState(() {
      messages.add(Message(text: _recordedFilePath, isSentByMe: true));
    });
  }
}
