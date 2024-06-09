import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EscreveTexto extends StatefulWidget {
  const EscreveTexto({super.key, required this.salvaMensagem});

  final Function({String? text, XFile? imgFile}) salvaMensagem;

  @override
  State<EscreveTexto> createState() => _EscreveTextoState();
}

class _EscreveTextoState extends State<EscreveTexto> {
  final TextEditingController captura_texto = TextEditingController();
  bool ativa_send = false;

  final imagePicker = ImagePicker();

  void reset() {
    captura_texto.clear();
    setState(() {
      ativa_send = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                final imgFile =
                    await imagePicker.pickImage(source: ImageSource.camera);
                if (imgFile == null) return;
                widget.salvaMensagem(imgFile: imgFile); // Adicione esta linha para enviar a imagem
              },
              icon: Icon(Icons.photo_camera)),
          Expanded(
              child: TextField(
            controller: captura_texto,
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensagem!'),
            onChanged: (text) => {
              setState(() {
                ativa_send = text.isNotEmpty;
              })
            },
            onSubmitted: (text) {
              widget.salvaMensagem(text: text);
              reset();
            },
          )),
          IconButton(
              onPressed: ativa_send
                  ? () {
                      widget.salvaMensagem(text: captura_texto.text);
                      reset();
                    }
                  : null,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
