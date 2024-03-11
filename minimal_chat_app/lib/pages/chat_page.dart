import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_chat_app/auth_service/auth_service.dart';
import 'package:minimal_chat_app/auth_service/chat_service.dart';
import 'package:minimal_chat_app/components/text_field.dart';
import 'package:minimal_chat_app/models/message_model.dart';

class ChatPage extends StatefulWidget {
  String recieversEmail;
  String receiversID;
  ChatPage(
      {super.key, required this.recieversEmail, required this.receiversID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiversID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> parts = widget.recieversEmail.split('@');
    String username = parts[0];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            username,
            style: GoogleFonts.roboto(),
          ),
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.deepPurpleAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 1.0],
            ),
          ),
          child: Column(
            // mainAxisAlignment: ,
            children: [
              Expanded(
                child: _buildMessagesList(),
              ),
              _buildUserInput(messageController)
            ],
          ),
        ));
  }

  Widget _buildMessagesList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getmessages(senderId, widget.receiversID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList());
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;
    bool isSender = isCurrentUser ? true : false;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var color = isSender ? (Colors.blue) : Colors.deepPurpleAccent;
    // return Container(alignment: alignment, child: Text(data['message']!));
    return BubbleNormal(
      text: data['message'],
      isSender: isSender,
      color: color,
      tail: true,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  Widget _buildUserInput(TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(width: 2, color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    fillColor: Colors.amberAccent,
                    // filled: true,
                    hintText: "Enter a message to send"),
              ),
            ),
            IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  size: 32,
                  color: Colors.deepPurpleAccent,
                ))
          ],
        ),
      ),
    );
  }
}
