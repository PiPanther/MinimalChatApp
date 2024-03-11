import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_chat_app/auth_service/auth_service.dart';
import 'package:minimal_chat_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() async {
      final auth = AuthService();
      auth.userLogout();
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: LottieBuilder.asset('lib/assets/login_page.json'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("H O M E"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("S E T T I N G S"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SettingPage();
                },
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("L O G O U T"),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
