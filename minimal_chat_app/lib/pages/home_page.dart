import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_chat_app/auth_service/auth_service.dart';
import 'package:minimal_chat_app/auth_service/chat_service.dart';
import 'package:minimal_chat_app/components/my_drawer.dart';
import 'package:minimal_chat_app/components/user_list_tile.dart';
import 'package:minimal_chat_app/pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() async {
    final auth = AuthService();
    auth.userLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pegion",
          style: GoogleFonts.pacifico(),
        ),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          buildUserList(),
        ],
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: snapshot.data!
                .map((e) => buildUserLstTile(e, context))
                .toList(),
          );
        }
      },
    );
  }

  Widget buildUserLstTile(Map<String, dynamic> userData, BuildContext context) {
    return USerTile(
        text: userData["username"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatPage(
                recieversEmail: userData["email"],
                receiversID: userData["uid"],
              );
            },
          ));
        });
  }
}
