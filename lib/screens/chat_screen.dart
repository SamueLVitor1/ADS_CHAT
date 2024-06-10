import 'dart:io';

import 'package:ads_chat/widgets/chat_message.dart';
import 'package:ads_chat/widgets/escreve_texto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? _currentUser;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _currentUser = user;
    });

    if (_currentUser == null) {
      _getUser();
    }
  }

  Future<User?> _getUser() async {
    if (_currentUser != null) return _currentUser;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      setState(() {
        _currentUser = user;
      });
    } catch (error) {
      return null;
    }
  }

  void _salvaMensagem({String? text, XFile? imgFile}) async {
    final User? user = _currentUser;

    if (user == null) {
      print("Não foi possível realizar o login, tente novamente!");
      _getUser();
    } else {
      Map<String, dynamic> data = {
        "uid": user!.uid,
        "senderName": user.displayName,
        "senderPhotoUrl": user.photoURL
      };

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

      data['dt_envio'] = Timestamp.now();

      FirebaseFirestore.instance.collection('Mensagens').add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentUser == null
            ? const Text('Ads Chat')
            : Text(_currentUser!.displayName ?? 'Ads Chat'),
        backgroundColor: Colors.lime[100],
        actions: [
          IconButton(
            icon: Icon(_currentUser == null ? Icons.login : Icons.logout),
            onPressed: () {
              if (_currentUser == null) {
                _getUser();
              } else {
                FirebaseAuth.instance.signOut();
                setState(() {
                  _currentUser = null;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Mensagens')
                  .orderBy('dt_envio', descending: true)
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
                    final List<DocumentSnapshot<Map<String, dynamic>>>
                        messages = snapshot.data!.docs.toList()
                            as List<DocumentSnapshot<Map<String, dynamic>>>;
                    return ListView.builder(
                      itemCount: messages.length,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      itemBuilder: (context, index) {
                        final messageData =
                            messages[index].data() as Map<String, dynamic>;
                        final String? uid = messageData['uid'];
                        final bool minha =
                            uid == _currentUser?.uid ? true : false;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ChatMessage(
                            data: messageData,
                            minha: minha,
                          ),
                        );
                      },
                    );
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
