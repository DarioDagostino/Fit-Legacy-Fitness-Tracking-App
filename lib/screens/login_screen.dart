import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/validators.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_routes.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_logo.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      _signIn();
    }
  }

  Future<void> _signIn() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
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
                  // Logo placeholder — replace with Image.asset or SvgPicture for pixel-perfect
                  const AuthLogo(size: 74),
                  const SizedBox(height: 12),
                  Text(AppStrings.loginTitle, style: AppTextStyles.headline1.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('Bienvenido de nuevo', style: AppTextStyles.body1.copyWith(color: Colors.white)),
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
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: Text(AppStrings.loginButton, style: AppTextStyles.button.copyWith(color: AppColors.primary)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.signup), child: Text(AppStrings.signupButton)),
                        TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.reset), child: Text(AppStrings.resetButton)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.caminoLegado), child: const Text('Skip (dev)')),
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
