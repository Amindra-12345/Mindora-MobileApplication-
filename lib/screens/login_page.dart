import 'package:flutter/material.dart';

import '../theme/mindora_colors.dart';
import 'register.dart';
import 'forgotpassword.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(leading: const BackButton()),
      backgroundColor: MindoraColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Text(
                  'Mindora',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: MindoraColors.highlight,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Plan it. Focus on it. Review it.',
                  style: TextStyle(color: MindoraColors.muted),
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 15),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Connect login later.
                    },
                    child: const Text('Log in'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Connect Google login later.
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Log in with Google'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have Account?",
                      style: TextStyle(color: MindoraColors.text),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Color.fromARGB(255, 227, 128, 92),
                        ),
                      ),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Forgotpassword(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(color: MindoraColors.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
