import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_chat_app/auth_service/auth_service.dart';
import 'package:minimal_chat_app/components/myButton.dart';
import 'package:minimal_chat_app/components/text_field.dart';
import 'package:minimal_chat_app/pages/home_page.dart';

class RegistePage extends StatefulWidget {
  const RegistePage({super.key});

  @override
  State<RegistePage> createState() => _RegistePageState();
}

class _RegistePageState extends State<RegistePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrmpasswordController = TextEditingController();
  void register() {
    final auth = AuthService();
    if (passwordController.text.trim() ==
        confrmpasswordController.text.trim()) {
      try {
        auth
            .signUpUserWithEmailandPassword(
                emailController.text, passwordController.text)
            .then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ));
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text(e.toString()));
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(title: Text("Passwords do not match"));
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
            const SizedBox(
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
            const SizedBox(
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
            MyTextField(
              text: "Re-Enter Password",
              controller: confrmpasswordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),

            // register now
            MyButton(text: 'Login', onTap: register),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a Member?  "),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
