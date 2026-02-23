import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/core/providers/current_user_notifier.dart';
import 'package:music_player/features/Auth/viewmodel/auth_viewmodel.dart';
import 'package:music_player/features/splashscreen/splash_screen.dart';
import 'package:music_player/core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPrefrences();
  await container.read(authViewModelProvider.notifier).getData();
  await Hive.initFlutter();
  await Hive.openBox('songsBox');

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Nothing Music',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: SplashScreen(currentUser: currentUser),
    );
  }
}
