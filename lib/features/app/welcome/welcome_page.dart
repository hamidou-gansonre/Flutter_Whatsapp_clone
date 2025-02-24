import 'package:flutter/material.dart';
import 'package:whatsapp_app/features/app/theme/style.dart';
import 'package:whatsapp_app/features/user/presentation/pages/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Text(
                'Bienvenu sur Whatsapp Clone',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                ),
              ),
            ),
            Image.asset("assets/bg_image.png"),
            Column(
              children: [
                const Text(
                  "Read our Privacy Policy tap, 'Agree and Continue' to accept the Team of service. ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                        child: Text(
                      'ACCEPTER ET CONTINUER',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
