import 'package:flutter/material.dart';

import '../theme/mindora_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Login"),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Register"),
                      ),
                    ),
                  ],
                ),
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

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: MindoraColors.muted),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
