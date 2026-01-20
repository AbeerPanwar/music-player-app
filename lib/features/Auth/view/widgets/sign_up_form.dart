import 'package:client_/features/Auth/repository/auth_remote_repository.dart';
import 'package:client_/theme/app_pallet.dart';
import 'package:client_/theme/theme.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                  fontFamily: 'Zain',
                ),
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  errorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  hintText: 'Joe Adams',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Pallete.geryGradiant1,
                    fontFamily: 'Zain',
                  ),
                  suffixIcon: Icon(Icons.person, color: Pallete.geryGradiant2),
                  focusedErrorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  enabledBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.focusedBorder,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                  fontFamily: 'Zain',
                ),
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Joe@gmail.com',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Pallete.geryGradiant1,
                    fontFamily: 'Zain',
                  ),
                  suffixIcon: Icon(Icons.email, color: Pallete.geryGradiant2),
                  errorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  focusedErrorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  enabledBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.focusedBorder,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                  fontFamily: 'Zain',
                ),
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Pallete.geryGradiant1,
                    fontFamily: 'Zain',
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Pallete.geryGradiant2,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  errorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  focusedErrorBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  enabledBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      AppTheme.darkThemeMode.inputDecorationTheme.focusedBorder,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await AuthRemoteRepository().signUp(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.geryGradiant2,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Pallete.backgroundColor,
                    fontFamily: 'Zain',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
