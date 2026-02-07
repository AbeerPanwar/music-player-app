import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/core/theme/app_pallet.dart';
import 'package:music_player/features/Home/view/pages/library_page.dart';
import 'package:music_player/features/Home/view/pages/profile_page.dart';
import 'package:music_player/features/Home/view/pages/search_page.dart';
import 'package:music_player/features/Home/view/pages/songs_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  final pages = const [SongsPage(), SearchPage(), LibraryPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: SalomonBottomBar(
          currentIndex: currentIndex,
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Image.asset(
                currentIndex == 0
                    ? 'lib/core/assets/images/home_filled.png'
                    : 'lib/core/assets/images/home_unfilled.png',
                scale: 1.1,
                color: currentIndex == 0
                    ? Pallete.whiteColor
                    : Pallete.greyColor,
              ),
              title: const Text("Home"),
              selectedColor: Pallete.gradient1,
            ),
            SalomonBottomBarItem(
              icon: Image.asset(
                currentIndex == 1
                    ? 'lib/core/assets/images/search_filled.png'
                    : 'lib/core/assets/images/search_unfilled.png',
                scale: 1,
                color: currentIndex == 1
                    ? Pallete.whiteColor
                    : Pallete.greyColor,
              ),
              title: const Text("Search"),
              selectedColor: Pallete.gradient1,
            ),
            SalomonBottomBarItem(
              icon: Image.asset(
                'lib/core/assets/images/library.png',
                scale: 1,
                color: currentIndex == 2
                    ? Pallete.whiteColor
                    : Pallete.greyColor,
              ),
              title: const Text("Library"),
              selectedColor: Pallete.gradient1,
            ),
            SalomonBottomBarItem(
              icon: Icon(
                currentIndex == 3 ? Icons.person : Icons.person_outline,
                color: currentIndex == 3
                    ? Pallete.whiteColor
                    : Pallete.greyColor,
                size: 27,
              ),
              title: const Text("Profile"),
              selectedColor: Pallete.gradient1,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade800,
              Colors.grey.shade900,
              Colors.black12,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: pages[currentIndex],
      ),
    );
  }
}
