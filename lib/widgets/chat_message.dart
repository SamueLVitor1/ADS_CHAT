import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.data, required this.minha});

  final bool minha;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          !minha
              ? GestureDetector(
                  onTap: () {
                    _showImage(context, data['senderPhotoUrl']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(data['senderPhotoUrl'])),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: minha
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(data['senderName'],
                    style: minha
                        ? const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500)
                        : const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500)),
                data['imgUrl'] != null
                    ? GestureDetector(
                        onTap: () {
                          _showImage(context, data['imgUrl']);
                        },
                        child: Image.network(
                          data['imgUrl'],
                          width: 200,
                        ),
                      )
                    : Text(
                        data['texto'],
                        style: const TextStyle(fontSize: 18),
                      ),
              ],
            ),
          ),
          minha
              ? GestureDetector(
                  onTap: () {
                    _showImage(context, data['senderPhotoUrl']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(data['senderPhotoUrl'])),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _showImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        );
      },
    );
  }
}