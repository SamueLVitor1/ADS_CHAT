import 'package:flutter/material.dart';

class EscreveTexto extends StatefulWidget {
  const EscreveTexto({super.key, required this.salvaMensagem});

  final Function(String) salvaMensagem;

  @override
  State<EscreveTexto> createState() => _EscreveTextoState();
}

class _EscreveTextoState extends State<EscreveTexto> {
  final TextEditingController captura_texto = TextEditingController();
  bool ativa_send = false;

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
          const IconButton(onPressed: null, icon: Icon(Icons.photo_camera)),
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
              widget.salvaMensagem(text);
              reset();
            },
          )),
          IconButton(
              onPressed: ativa_send
                  ? () {
                      widget.salvaMensagem(captura_texto.text);
                      reset();
                    }
                  : null,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
