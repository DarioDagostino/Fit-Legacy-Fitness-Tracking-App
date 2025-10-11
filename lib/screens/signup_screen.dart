import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_logo.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _signup();
    }
  }

  Future<void> _signup() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/camino');
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
                  Text(AppStrings.signupTitle, style: AppTextStyles.headline1.copyWith(color: Colors.white)),
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
                    const SizedBox(height: 12),
                    _PasswordField(controller: _passwordController),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(AppStrings.signupButton, style: AppTextStyles.button.copyWith(color: AppColors.primary))),
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

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: AppStrings.passwordLabel,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _obscure = !_obscure)),
      ),
      validator: Validators.validatePassword,
      obscureText: _obscure,
      style: AppTextStyles.body1.copyWith(color: AppColors.textPrimary),
    );
  }
}
