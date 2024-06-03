import 'package:ads_chat/widgets/escreve_texto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _salvaMensagem(String text){
    FirebaseFirestore.instance.collection('Mensagem').add({
      'texto': text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ola'),),
      body: EscreveTexto(salvaMensagem: _salvaMensagem,),
    );
  }
}