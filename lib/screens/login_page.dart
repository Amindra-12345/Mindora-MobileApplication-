import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../theme/mindora_colors.dart';
import 'register.dart';
import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool obscure = true;
  bool isLoading = false;

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: MindoraColors.muted.withOpacity(0.8)),
      prefixIcon: Icon(icon, color: MindoraColors.primary),
      suffixIcon: suffix,
      filled: true,
      fillColor: MindoraColors.background,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: MindoraColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: MindoraColors.primary, width: 1.6),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email and password')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      dynamic data;

      try {
        data = jsonDecode(response.body);
      } catch (_) {
        data = <String, dynamic>{};
      }

      if (!mounted) return;

      if (response.statusCode == 200) {
        final token = data is Map ? data['token'] : null;

        if (token == null || token.toString().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Login succeeded, but the server did not return a token.',
              ),
            ),
          );
          return;
        }

        await secureStorage.write(key: 'jwt_token', value: token.toString());
        debugPrint('JWT TEST: Login function reached token section');
        final protectedResponse = await http.get(
          Uri.parse('http://10.0.2.2:5000/api/auth/protected'),
          headers: {'Authorization': 'Bearer ${token.toString()}'},
        );

        debugPrint('Protected API status: ${protectedResponse.statusCode}');
        debugPrint('Protected API response: ${protectedResponse.body}');

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Your teammate's Home Screen can be opened here later.
      } else {
        final message = data is Map ? data['message']?.toString() : null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? 'Login failed. Please try again.')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cannot connect to server. Check that the backend is running.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MindoraColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MindoraColors.background,
              MindoraColors.highlight.withOpacity(0.22),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -50,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MindoraColors.gold.withOpacity(0.16),
                ),
              ),
            ),
            Positioned(
              bottom: -90,
              left: -70,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MindoraColors.primary.withOpacity(0.14),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mindora logo badge
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MindoraColors.gold,
                            width: 2,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                MindoraColors.highlight,
                                MindoraColors.primary,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: MindoraColors.primary.withOpacity(0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.psychology_alt_rounded,
                            size: 38,
                            color: MindoraColors.surface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Mindora',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: MindoraColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 48,
                        height: 3,
                        decoration: BoxDecoration(
                          color: MindoraColors.gold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Plan it. Focus on it. Review it.',
                        style: TextStyle(
                          color: MindoraColors.muted,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Login card
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 420),
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: MindoraColors.surface,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: MindoraColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: MindoraColors.primary.withOpacity(0.12),
                              blurRadius: 30,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Email
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              style: const TextStyle(color: MindoraColors.text),
                              cursorColor: MindoraColors.primary,
                              decoration: _fieldDecoration(
                                hint: 'Enter your email',
                                icon: Icons.email_outlined,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password
                            TextField(
                              controller: passwordController,
                              obscureText: obscure,
                              autofillHints: const [AutofillHints.password],
                              style: const TextStyle(color: MindoraColors.text),
                              cursorColor: MindoraColors.primary,
                              decoration: _fieldDecoration(
                                hint: 'Password',
                                icon: Icons.lock_outline_rounded,
                                suffix: IconButton(
                                  icon: Icon(
                                    obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: MindoraColors.muted,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                ),
                              ),
                              onSubmitted: (_) => login(),
                            ),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Forgotpassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: MindoraColors.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [
                                      MindoraColors.primary,
                                      MindoraColors.text,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MindoraColors.primary.withOpacity(
                                        0.35,
                                      ),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledBackgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: MindoraColors.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: isLoading ? null : login,
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: MindoraColors.surface,
                                          ),
                                        )
                                      : const Text(
                                          'Log in',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Divider
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(color: MindoraColors.border),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      color: MindoraColors.muted,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: MindoraColors.border),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Google login placeholder
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: MindoraColors.text,
                                  backgroundColor: MindoraColors.background,
                                  side: const BorderSide(
                                    color: MindoraColors.gold,
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Google sign-in is not connected yet.',
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.login,
                                  color: MindoraColors.gold,
                                ),
                                label: const Text('Log in with Google'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Text(
                              "Don't have Account?",
                              style: TextStyle(color: MindoraColors.text),
                            ),
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
                              'Register Now',
                              style: TextStyle(
                                color: MindoraColors.gold,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
