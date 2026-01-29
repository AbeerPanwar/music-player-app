import 'package:music_player/features/Auth/view/widgets/sign_in_form.dart';
import 'package:music_player/features/Auth/view/widgets/sign_up_form.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade800, Colors.black12, Colors.black54],
            begin: Alignment.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Nothing Music',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Pallete.gradient1,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Zain',
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Enjoy music — Anytime, Anywhere',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Pallete.whiteColor,
                          fontFamily: 'Zain',
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      _tabController.index == 0 ? 'Welcome' : 'Sign Up',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Pallete.geryGradiant1,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _tabController.index == 0
                          ? 'To get started, please sign in using your username and password.'
                          : 'To get started, please sign up inputing below fields information.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Pallete.geryGradiant2,
                        fontFamily: 'Zain',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Pallete.geryGradiant2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TabBar(
                          overlayColor: const WidgetStatePropertyAll(
                            Pallete.backgroundColor,
                          ),
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Pallete.geryGradiant3,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          dividerColor: Pallete.backgroundColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Pallete.gradient1,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Zain',
                          ),
                          unselectedLabelColor: Pallete.backgroundColor,
                          tabs: const [
                            Tab(text: 'Sign In'),
                            Tab(text: 'Sign Up'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [SignInForm(), SignUpForm()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
