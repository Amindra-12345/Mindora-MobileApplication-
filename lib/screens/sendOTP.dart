import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindora/screens/login_page.dart';

import '../theme/mindora_colors.dart';

class Sendotp extends StatefulWidget {
  const Sendotp({super.key});

  @override
  State<Sendotp> createState() => _SendotpState();
}

class _SendotpState extends State<Sendotp> {
  static const String defaultOtp = '111111';

  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _otpFocusNodes;

  @override
  void initState() {
    super.initState();

    // Automatically fill all six OTP boxes with 111111.
    _otpControllers = List.generate(
      6,
      (index) => TextEditingController(text: defaultOtp[index]),
    );

    _otpFocusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }

    for (final focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  // Check the entered OTP when Submit is clicked.
  void _submitOtp() {
    final enteredOtp = _otpControllers
        .map((controller) => controller.text)
        .join();

    if (enteredOtp == defaultOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP. Please enter 111111.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  InputDecoration _otpDecoration() {
    return InputDecoration(
      counterText: '',
      filled: true,
      fillColor: MindoraColors.background,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: MindoraColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: MindoraColors.primary, width: 1.6),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: MindoraColors.primary),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
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
            // Decorative gold circle.
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

            // Decorative green circle.
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
                      // Mindora logo.
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MindoraColors.gold,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MindoraColors.primary.withOpacity(0.25),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Container(
                            width: 110,
                            height: 110,
                            padding: const EdgeInsets.all(14),
                            color: MindoraColors.background,
                            child: Image.asset(
                              'assets/images/mindora_logo.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

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

                      // OTP card.
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
                            const Text(
                              'Enter OTP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: MindoraColors.text,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Type the 6-digit code we sent to your email.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MindoraColors.muted,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Six OTP input boxes.
                            Row(
                              children: List.generate(6, (index) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: index == 5 ? 0 : 8,
                                    ),
                                    child: TextField(
                                      controller: _otpControllers[index],
                                      focusNode: _otpFocusNodes[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: MindoraColors.text,
                                      ),
                                      cursorColor: MindoraColors.primary,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(1),
                                      ],
                                      decoration: _otpDecoration(),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (index < 5) {
                                            _otpFocusNodes[index + 1]
                                                .requestFocus();
                                          } else {
                                            _otpFocusNodes[index].unfocus();
                                          }
                                        } else if (index > 0) {
                                          _otpFocusNodes[index - 1]
                                              .requestFocus();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ),

                            const SizedBox(height: 24),

                            // Submit button.
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
                                  onPressed: _submitOtp,
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Login navigation.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have An Account?',
                            style: TextStyle(color: MindoraColors.text),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
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
