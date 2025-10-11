import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_logo.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _reset();
    }
  }

  Future<void> _reset() async {
    try {
      final email = _emailController.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent if email exists')));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Auth error')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF0B1220)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: AuthCard(
              header: Column(
                children: [
                  const AuthLogo(size: 74),
                  const SizedBox(height: 12),
                  Text(AppStrings.resetTitle, style: AppTextStyles.headline1.copyWith(color: Colors.white)),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: AppStrings.emailLabel, prefixIcon: Icon(Icons.email_outlined)),
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTextStyles.body1.copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(AppStrings.resetButton, style: AppTextStyles.button.copyWith(color: AppColors.primary))),
                    ),
                    const SizedBox(height: 8),
                    TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.login), child: Text(AppStrings.loginTitle)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
