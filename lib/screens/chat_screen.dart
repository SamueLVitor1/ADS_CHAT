import 'dart:io';

import 'package:ads_chat/widgets/escreve_texto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _salvaMensagem({String? text, XFile? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      final myPhoto = File(imgFile.path);
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(myPhoto);
      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }

    if (text != null) data['texto'] = text;

    FirebaseFirestore.instance
        .collection('Mensagens')
        .add(data); // Corrigido o nome da coleção aqui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads Chat'),
        backgroundColor: Colors.lime[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      'Mensagens') // Certifique-se de que o nome da coleção está correto
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma mensagem encontrada'),
                      );
                    }
                    List<DocumentSnapshot> messages =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(messages[index]['texto'] ??
                                'Mensagem sem texto'),
                          );
                        });
                }
              },
            ),
          ),
          EscreveTexto(
            salvaMensagem: _salvaMensagem,
          ),
        ],
      ),
    );
  }
}
