import 'package:flutter/material.dart';

import '../theme/mindora_colors.dart';
import 'register.dart';
import 'forgotpassword.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
  Widget build(BuildContext context) {
    bool obscure = true;

    return Scaffold(
      //appBar: AppBar(leading: const BackButton()),
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
            // Decorative soft circles (green + gold)
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
                      // Logo badge with gold ring
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
                      // Gold accent line
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

                      // Card
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
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: MindoraColors.text),
                              cursorColor: MindoraColors.primary,
                              decoration: _fieldDecoration(
                                hint: 'Enter your email',
                                icon: Icons.email_outlined,
                              ),
                            ),
                            const SizedBox(height: 16),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return TextField(
                                  obscureText: obscure,
                                  style: const TextStyle(
                                    color: MindoraColors.text,
                                  ),
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
                                      onPressed: () =>
                                          setState(() => obscure = !obscure),
                                    ),
                                  ),
                                );
                              },
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
                                  "Forgot Password",
                                  style: TextStyle(
                                    color: MindoraColors.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Green gradient login button
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
                                    shadowColor: Colors.transparent,
                                    foregroundColor: MindoraColors.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Connect login later.
                                  },
                                  child: const Text(
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

                            // Google button
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 52,
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: MindoraColors.text,
                                        backgroundColor:
                                            MindoraColors.background,
                                        side: const BorderSide(
                                          color: MindoraColors.gold,
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Connect Google login later.
                                      },
                                      icon: const Icon(
                                        Icons.login,
                                        color: MindoraColors.gold,
                                      ),
                                      label: const Text('Log in with Google'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
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
