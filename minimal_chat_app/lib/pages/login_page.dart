import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_chat_app/auth_service/auth_service.dart';
import 'package:minimal_chat_app/components/myButton.dart';
import 'package:minimal_chat_app/components/text_field.dart';
import 'package:minimal_chat_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          emailController.text.trim(), passwordController.text.trim());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(e.toString()));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            // logo
            LottieBuilder.asset(
              "lib/assets/login_page.json",
              width: 250,
            ),
            //welcome back message
            Text(
              "Welcome Back \n You have been missed !",
              style: GoogleFonts.pacifico(fontSize: 22),
            ),
            SizedBox(
              height: 90,
            ),

            // email textfield
            MyTextField(
              text: "Enter Email",
              controller: emailController,
              obscureText: false,
            ),

            // password textfield
            MyTextField(
              text: "Enter Password",
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),
            // register now
            MyButton(text: 'Login', onTap: login),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a Member?  "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegistePage();
                      }));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
