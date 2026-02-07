import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/utils.dart';
import 'package:music_player/core/widgets/loader.dart';
import 'package:music_player/features/Auth/view/pages/auth_page.dart';
import 'package:music_player/features/Auth/viewmodel/auth_viewmodel.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
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
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackbar(context, 'Account Created Succesfully! Please Signin..');
          //TODO: animate the navigation
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
          );
        },
        error: (error, st) {
          showSnackbar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: isLoading
          ? const Loader(
              color: Pallete.gradient1,
              backgroundColor: Pallete.transparentColor,
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.whiteColor,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        errorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        hintText: 'Joe Adams',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Pallete.geryGradiant1,
                          fontFamily: 'Zain',
                        ),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: Pallete.geryGradiant2,
                        ),
                        focusedErrorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        enabledBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        focusedBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .focusedBorder,
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
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.whiteColor,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(height: 3),
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
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Pallete.geryGradiant2,
                        ),
                        errorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        focusedErrorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        enabledBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        focusedBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .focusedBorder,
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
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.whiteColor,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(height: 3),
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
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        errorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        focusedErrorBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        enabledBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .enabledBorder,
                        focusedBorder: AppTheme
                            .darkThemeMode
                            .inputDecorationTheme
                            .focusedBorder,
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
                        HapticFeedback.selectionClick();
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .userSignUp(
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
